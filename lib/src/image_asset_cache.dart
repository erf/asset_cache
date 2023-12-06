import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset cache for Image assets
class ImageAssetCache extends AssetCache<Image> {
  ImageAssetCache({
    super.basePath,
    super.assetBundle,
  }) : super(
            decoder: (ByteData data) =>
                decodeImageFromList(data.buffer.asUint8List()));
}
