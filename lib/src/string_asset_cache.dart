import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset cache for strings
class StringAssetCache extends AssetCache<String> {
  StringAssetCache({
    String? basePath,
    AssetBundle? assetBundle,
  }) : super(
          decoder: (ByteData data) => utf8.decode(data.buffer.asUint8List()),
          basePath: basePath,
          assetBundle: assetBundle,
        );
}
