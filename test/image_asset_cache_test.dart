import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'file_asset_bundle.dart';

void main() {
  // initiate paint binding
  WidgetsFlutterBinding.ensureInitialized();

  group("ByteDataAssetCache tests", () {
    test('Load test.png and verify image', () async {
      final cache = ImageAssetCache(assetBundle: FileAssetBundle());
      final image = await cache.load('test/assets/test.png');
      expect(image.width, 54);
      expect(image.height, 54);
    });
  });
}
