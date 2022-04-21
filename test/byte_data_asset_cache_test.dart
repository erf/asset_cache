import 'dart:convert';
import 'dart:typed_data';

import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MyByteBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) {
    final byteData = ByteData.view(Uint8List.fromList(utf8.encode(key)).buffer);
    return Future.value(byteData);
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}

void main() {
  group("ByteDataAssetCache tests", () {
    test('write key as ByteData value and fetch it', () async {
      final cache = ByteDataAssetCache(assetBundle: MyByteBundle());
      final ByteData result = await cache.load("test");
      final String str = utf8.decode(result.buffer.asUint8List());
      expect(str, "test");
    });
  });
}
