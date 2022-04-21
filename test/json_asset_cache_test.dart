import 'package:asset_cache/asset_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'file_asset_bundle.dart';

void main() {
  group('JsonAssetCache tests', () {
    test('Load test.json and verify json', () async {
      final cache = JsonAssetCache(assetBundle: FileAssetBundle());
      final json = await cache.load('test/assets/test.json');
      expect(json['imageRect']['image'], 'rogue.png');
    });
  });
}
