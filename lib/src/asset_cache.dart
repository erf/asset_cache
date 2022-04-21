import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'generic_cache.dart';

/// Given a [ByteData] return a type [T]
typedef AssetDecoder<T> = FutureOr<T> Function(ByteData);

/// Generic cache for loading assets of type [T] given an [AssetDecoder]
class AssetCache<T> extends GenericCache<T> {
  /// Decode asset bytes to type T
  final AssetDecoder<T> decoder;

  /// Optional asset bundle
  final AssetBundle? assetBundle;

  /// Constructor for [AssetCache] with [decoder] and optional [assetBundle] and [basePath]
  AssetCache({
    required this.decoder,
    this.assetBundle,
    String? basePath,
  }) : super(basePath: basePath);

  /// Load and decode an asset from a bundle given a [key]
  @override
  Future<T> loadAsset(String key) async {
    final String fullPath = path.join(basePath ?? '', key);
    return await decoder(await (assetBundle ?? rootBundle).load(fullPath));
  }
}
