import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';

import 'asset_cache.dart';

/// An asset caches for images
class ImageAssets extends AssetCache<Image> {
  ImageAssets()
      : super(
            (ByteData data) => decodeImageFromList(data.buffer.asUint8List()));
}
