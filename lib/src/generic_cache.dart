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
}
