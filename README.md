# asset_cache

**asset_cache** will load and cache any asset of type `T` given a decoder. 

I made this since [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html) does not cache binary data.

> Binary resources (from load) are not cached.

## Usage

Describe assets in your `pubspec.yaml`:

```
  assets:
     - assets/images/
     - assets/json/
```

Create asset cache objects with an optional `basePath` to avoid using full asset paths:

```
final imageCache = ImageAssetCache(basePath: "assets/images/");
final jsonCache = JsonAssetCache(basePath: "assets/json/");
```

Load and cache assets using `load`, which returns a `Future<T>`:

```
final image = await imageCache.load('sprite.png')
final json = await jsonCache.load('sprite.json')
```

We include the following `AssetCache` implementations:

- ImageAssetCache
- JsonAssetCache
- TextAssetCache
- ByteDataAssetCache

## Custom AssetCache

Create a custom asset cache by inheriting from `AssetCache` and pass it a `AssetDecoder`.

You can also inherit from `GenericCache` and override `loadAsset`, if you don't want to load from a `AssetBundle`.

## More

See [example](example) and [test](test).
