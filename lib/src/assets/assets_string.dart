import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for strings
class StringAssets extends AssetCache<String> {
  StringAssets({String basePath})
      : super(
            (ByteData data) =>
                Future.value(utf8.decode(data.buffer.asUint8List())),
            basePath: basePath);
}
