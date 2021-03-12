import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for images
class ImageAssetCache extends AssetCache<Image> {
  ImageAssetCache({String? basePath, AssetBundle? bundle})
      : super((ByteData data) => decodeImageFromList(data.buffer.asUint8List()),
            basePath: basePath, bundle: bundle);
}
