import 'dart:convert';

import 'package:flutter/services.dart';

import 'asset_cache.dart';

/// A singleton asset caches for strings
class StringAssets extends AssetCache<String> {
  static final _decoder =
      (ByteData data) => Future.value(utf8.decode(data.buffer.asUint8List()));

  StringAssets._privateConstructor() : super(_decoder);

  static final StringAssets instance = StringAssets._privateConstructor();
}
