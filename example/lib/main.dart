import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';

void main() {
  StringAssets.instance.basePath = 'assets/strings/';
  ByteDataAssets.instance.basePath = 'assets/images/';
  JsonAssets.instance.basePath = 'assets/json/';
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
              future: StringAssets.instance.load('hello.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder<ByteData>(
              future: ByteDataAssets.instance.load('angel.png'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data.buffer.asUint8List());
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder(
              future: JsonAssets.instance.load('sprite.json'),
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
