import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'generic_cache.dart';

/// The asset decoder declaration
///
/// Given a [ByteData] returns a type [T]
typedef AssetDecoder<T> = Future<T> Function(ByteData);

/// A generic cache for loading assets of type [T] given an [AssetDecoder]
class AssetCache<T> extends GenericCache<T> {
  /// decode asset bytes to type T
  AssetDecoder<T> decoder;

  /// optional asset bundle
  AssetBundle bundle;

  /// add asset decoder in constructor, and optional bundle
  AssetCache(this.decoder, {this.bundle, String basePath})
      : super(basePath: basePath);

  /// load an asset from a bundle given a key and optional base path and
  /// decode the asset using a given decoder
  Future<T> loadAsset(String name) async {
    final String key = basePath == null ? name : basePath + name;
    return await decoder(await (bundle ?? rootBundle).load(key));
  }
}
