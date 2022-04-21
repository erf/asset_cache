import 'dart:io';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MyAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) {
    return File(key).readAsBytes().then((value) => value.buffer.asByteData());
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}

void main() {
  group("StringAssetCache tests", () {
    test('Load test.txt and verify text', () async {
      final cache = StringAssetCache(assetBundle: MyAssetBundle());
      final String text = await cache.load("test/assets/test.txt");
      expect(text, 'Hello, world!');
    });
  });
}
