import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';

final stringAssets = StringAssetCache(basePath: 'assets/strings/');
final stringAssetsWithoutBasePath = StringAssetCache();
final jsonAssets = JsonAssetCache(basePath: 'assets/json/');
final imageAssets = ImageAssetCache(basePath: 'assets/images/');
final byteAssets = ByteDataAssetCache(basePath: 'assets/images/');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'asset cache demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MyImagePainter extends CustomPainter {
  final ui.Image image;

  MyImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final myPaint = Paint();

    canvas.save();
    canvas.translate(100, 100);
    canvas.rotate(1.5);
    canvas.scale(3.0);
    canvas.drawImage(image, Offset.zero, myPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('asset cache demo'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: stringAssets.load('hello.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data ?? '');
                } else {
                  return const Text('loading..');
                }
              },
            ),
            FutureBuilder<String>(
              future: stringAssetsWithoutBasePath
                  .load('assets/strings/hello-new-string.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data ?? '');
                } else {
                  return const Text('loading..');
                }
              },
            ),
            FutureBuilder<dynamic>(
              future: jsonAssets.load('sprite.json'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return const Text('loading..');
                }
              },
            ),
            FutureBuilder<ui.Image>(
              future: imageAssets.load('angel.png'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomPaint(
                    painter: MyImagePainter(snapshot.data!),
                  );
                } else {
                  return const Text('loading..');
                }
              },
            ),
            FutureBuilder<ByteData>(
              future: byteAssets.load('angel.png'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data!.buffer.asUint8List());
                } else {
                  return const Text('loading..');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
