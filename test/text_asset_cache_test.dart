import 'package:asset_cache/asset_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'file_asset_bundle.dart';

void main() {
  group('TextAssetCache tests', () {
    test('Load test.txt and verify text', () async {
      final cache = TextAssetCache(assetBundle: FileAssetBundle());
      final String text = await cache.load('test/assets/test.txt');
      expect(text, 'Hello, world!');
    });
  });
}
