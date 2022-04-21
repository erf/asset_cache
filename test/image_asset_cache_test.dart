import 'dart:io';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MyAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) {
    return File(key).readAsBytes().then((value) {
      return value.buffer.asByteData();
    });
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}

void main() {
  // initiate paint binding
  WidgetsFlutterBinding.ensureInitialized();

  group("ByteDataAssetCache tests", () {
    test('write key as ByteData value and fetch it', () async {
      final cache = ImageAssetCache(assetBundle: MyAssetBundle());
      final image = await cache.load('test/assets/test.png');
      expect(image.width, 54);
      expect(image.height, 54);
    });
  });
}
