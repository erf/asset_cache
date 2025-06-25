# asset_cache

**asset_cache** will load and cache any asset of type `T` given a decoder. 

It was made as [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html) does not cache binary data.

> Binary resources (from load) are not cached.

## Usage

Describe assets in your `pubspec.yaml`:

```
  assets:
     - assets/images/
     - assets/json/
```

Create asset cache instances with an optional `basePath` to avoid full paths:

```
final imageCache = ImageAssetCache(basePath: "assets/images/");
final jsonCache = JsonAssetCache(basePath: "assets/json/");
```

Load and cache assets using `load` returns a `Future<T>`:

```
final image = await imageCache.load('sprite.png')
final json = await jsonCache.load('sprite.json')
```

## Asset Decoders

The following `AssetCache` implementations are included:

- ImageAssetCache
- JsonAssetCache
- TextAssetCache
- ByteDataAssetCache

## Custom AssetCache

Create a custom asset cache by inheriting from `AssetCache` and pass it a `AssetDecoder`.

You can also inherit from `GenericCache` and override `loadAsset`, if you don't want to load from a `AssetBundle`.

### Cache Management

The cache provides several management methods:

```dart
// Load and cache an asset (returns cached version if already loaded)
final image = await imageCache.load('sprite.png');

// Check if an asset is cached
if (imageCache.contains('sprite.png')) {
  // Asset is already cached
}

// Get the number of cached items
print('Cached items: ${imageCache.size}');

// Remove a specific cached item
imageCache.remove('sprite.png');

// Clear all cached items
imageCache.clear();
```

### Preloading Assets

For better performance, you can preload multiple assets concurrently:

```dart
// Preload multiple assets at once
await imageCache.preload(['sprite1.png', 'sprite2.png', 'sprite3.png']);

// Remember to call this before preloading at app startup
WidgetsFlutterBinding.ensureInitialized();
```

### Exception Handling

The package includes custom exceptions for better error handling:

- `AssetNotFoundException` - Thrown when an asset cannot be found or loaded
- `DecodingException` - Thrown when an asset cannot be decoded to the expected type
- `PreLoadingAssetsNotFoundException` - Thrown when preloading fails for some assets

```dart
try {
  final image = await imageCache.load('missing.png');
} on AssetNotFoundException catch (e) {
  print('Asset not found: ${e.assetKey}');
} on DecodingException catch (e) {
  print('Failed to decode asset: ${e.assetKey}');
}
```

## More

See [example](example) and [test](test).
