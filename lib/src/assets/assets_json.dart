import 'dart:convert';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for json files
class JsonAssets extends AssetCache<dynamic> {
  JsonAssets({String basePath, AssetBundle bundle})
      : super(
            (ByteData data) => Future.value(
                jsonDecode(utf8.decode(data.buffer.asUint8List()))),
            basePath: basePath,
            bundle: bundle);
}
