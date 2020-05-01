import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';

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
              future: StringAssets.instance.load('assets/strings/hello.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder<Uint8List>(
              future: ImageAsUint8List.instance.load('assets/images/angel.png'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data);
                } else {
                  return Text('loading..');
                }
              },
            ),
            FutureBuilder(
              future: JsonAssets.instance.load('assets/json/sprite.json'),
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
