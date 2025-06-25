import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'exceptions.dart';
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
    super.basePath,
  });

  /// Load and decode an asset from a bundle given a [key]
  @override
  Future<T> loadAsset(String key) async {
    final String fullPath = path.join(basePath ?? '', key);

    // First, try to load the asset bytes
    final ByteData bytes;
    try {
      bytes = await (assetBundle ?? rootBundle).load(fullPath);
    } catch (e, stackTrace) {
      throw AssetNotFoundException(
        'Failed to load asset',
        assetKey: key,
        originalException: e,
        originalStackTrace: stackTrace,
      );
    }

    // Then, try to decode the asset
    try {
      final T asset = await decoder(bytes);
      return asset;
    } catch (e, stackTrace) {
      throw DecodingException(
        'Failed to decode asset',
        assetKey: key,
        originalException: e,
        originalStackTrace: stackTrace,
      );
    }
  }
}
