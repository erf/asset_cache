import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset cache for text files
class TextAssetCache extends AssetCache<String> {
  TextAssetCache({
    super.basePath,
    super.assetBundle,
  }) : super(
            decoder: (ByteData data) => utf8.decode(data.buffer.asUint8List()));
}
