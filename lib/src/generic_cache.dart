import 'dart:async';

import 'package:asset_cache/asset_cache.dart';

/// Abstract generic cache of type [T]
abstract class GenericCache<T> {
  /// A map for caching types of T in memory
  final Map<String, Future<T>> _cache = {};

  /// Optional base path so you don't have to type full path
  final String? basePath;

  /// Constructor for [GenericCache] with optional [basePath]
  GenericCache({this.basePath});

  /// Load and decode an asset from a bundle given a [key]
  Future<T> loadAsset(String key);

  /// Load an asset from the cache or load it from the asset bundle and cache it
  Future<T> load(String key) => _cache.putIfAbsent(key, () => loadAsset(key));

  /// Preload multiple assets concurrently for better performance
  /// Returns a Future that completes when all assets are loaded
  /// Remember to call `WidgetsFlutterBinding.ensureInitialized()` before initializing the cache at the start of your app
  /// This method will throw a [PreLoadingAssetsNotFoundException] if any asset fails to load
  Future<List<T>> preload(List<String> keys) async {
    // Start loading all assets concurrently
    final futures = keys.map((key) => load(key));

    // Wait for all to complete (including failures)
    try {
      return await Future.wait(futures, eagerError: true);
    } catch (e, stackTrace) {
      // Handle errors if needed, but they will be cached as failed Futures
      throw PreLoadingAssetsNotFoundException(
        'Failed to preload some assets: $e',
        assetKeys: keys,
        originalException: e,
        originalStackTrace: stackTrace,
      );
    }
  }

  /// Clear all cached items
  void clear() => _cache.clear();

  /// Remove a specific cached item by [key]
  /// Returns true if the item was present and removed, false otherwise
  bool remove(String key) => _cache.remove(key) != null;

  /// Check if an item with the given [key] is cached
  bool contains(String key) => _cache.containsKey(key);

  /// Get the number of cached items
  int get size => _cache.length;
}
