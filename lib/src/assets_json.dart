import 'dart:convert';

import 'package:flutter/services.dart';

import 'asset_cache.dart';

/// A singleton asset caches for json files
class JsonAssets extends AssetCache<dynamic> {
  static final _decoder = (ByteData data) =>
      Future.value(jsonDecode(utf8.decode(data.buffer.asUint8List())));

  JsonAssets._privateConstructor() : super(_decoder);

  static final JsonAssets instance = JsonAssets._privateConstructor();
}
