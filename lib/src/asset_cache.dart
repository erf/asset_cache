import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'generic_cache.dart';

/// The asset decoder declaration
///
/// Given a [ByteData] returns a type [T]
typedef AssetDecoder<T> = Future<T> Function(ByteData);

/// A generic cache for loading assets of type [T] given an [AssetDecoder]
class AssetCache<T> extends GenericCache<T> {
  /// Decode asset bytes to type T
  AssetDecoder<T> decoder;

  /// Optional asset bundle
  AssetBundle? bundle;

  /// Add asset decoder in constructor, and optional bundle
  AssetCache(this.decoder, {this.bundle, String? basePath})
      : super(basePath: basePath);

  /// Load an asset from a bundle given a key and optional base path and decode
  /// the asset using a given decoder
  Future<T> loadAsset(String name) async {
    final String key = path.join(basePath ?? '', name);
    return await decoder(await (bundle ?? rootBundle).load(key));
  }
}
