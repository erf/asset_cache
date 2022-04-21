import 'package:asset_cache/asset_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'file_asset_bundle.dart';

void main() {
  group("JsonAssetCache tests", () {
    test('write key as ByteData value and fetch it', () async {
      final cache = JsonAssetCache(assetBundle: FileAssetBundle());
      final json = await cache.load("test/assets/test.json");
      expect(json['imageRect']['image'], 'rogue.png');
    });
  });
}
