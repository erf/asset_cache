import 'dart:convert';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class KeyStringAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) {
    final byteData = Uint8List.fromList(utf8.encode(key)).buffer.asByteData();
    return Future.value(byteData);
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}

void main() {
  group('ByteDataAssetCache tests', () {
    test('Cache and load key as ByteData', () async {
      final cache = ByteDataAssetCache(assetBundle: KeyStringAssetBundle());
      final ByteData result = await cache.load('test');
      final String str = utf8.decode(result.buffer.asUint8List());
      expect(str, 'test');
    });
  });
}
