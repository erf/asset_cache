/// An abstract generic cache of type [T]
abstract class GenericCache<T> {
  /// a map for caching types of T in memory
  Map<String, Future<T>> _cache = {};

  /// optional base path so you don't have to type full path
  String? basePath;

  GenericCache({this.basePath});

  /// override to load a local asset given a key (filename)
  Future<T> loadAsset(String key);

  /// return resource if in cache, if not call [loadAsset]
  Future<T> load(String key) => _cache.putIfAbsent(key, () => loadAsset(key));
}
