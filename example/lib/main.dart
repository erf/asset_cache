import 'dart:typed_data';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';

final stringAssets = StringAssets(basePath: 'assets/strings/');
final byteAssets = ByteDataAssets(basePath: 'assets/images/');
final jsonAssets = JsonAssets(basePath: 'assets/json/');

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'asset cache demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asset cache demo'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: stringAssets.load('hello.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder<ByteData>(
              future: byteAssets.load('angel.png'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data.buffer.asUint8List());
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder(
              future: jsonAssets.load('sprite.json'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return Text('loading..');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
