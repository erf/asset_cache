import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset cache for JSON files
class JsonAssetCache extends AssetCache<dynamic> {
  JsonAssetCache({
    super.basePath,
    super.assetBundle,
  }) : super(
            decoder: (ByteData data) =>
                jsonDecode(utf8.decode(data.buffer.asUint8List())));
}
