import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for strings
class StringAssetCache extends AssetCache<String> {
  StringAssetCache({String? basePath, AssetBundle? bundle})
      : super(
            (ByteData data) =>
                Future.value(utf8.decode(data.buffer.asUint8List())),
            basePath: basePath,
            bundle: bundle);
}
