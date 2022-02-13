/// An abstract generic cache of type [T]
abstract class GenericCache<T> {
  /// A map for caching types of T in memory
  final Map<String, Future<T>> _cache = {};

  /// Optional base path so you don't have to type full path
  final String? basePath;

  GenericCache({this.basePath});

  /// Override to load a local asset given a key (filename)
  Future<T> loadAsset(String key);

  /// Return resource if in cache, if not call [loadAsset]
  Future<T> load(String key) => _cache.putIfAbsent(key, () => loadAsset(key));
}
