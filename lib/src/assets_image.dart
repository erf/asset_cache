import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';

import 'asset_cache.dart';

/// A singleton asset caches for images
class ImageAssets extends AssetCache<Image> {
  static final _decoder =
      (ByteData data) => decodeImageFromList(data.buffer.asUint8List());

  ImageAssets._privateConstructor() : super(_decoder);

  static final ImageAssets instance = ImageAssets._privateConstructor();
}
