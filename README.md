# asset_cache

**asset_cache** will load and cache any asset of type `T` given a decoder. 

Since `CachingAssetBundle` does not cache binary data, we `load` and cache data 
ourselves.

> Binary resources (from load) are not cached.

Create an asset cache by inheriting from `AssetCache` and give it a decoder. Or, 
inherit from `GenericCache` and override `loadAsset`.

**asset_cache** includes singletons for loading: *images*, *json*, *strings* and *byte data*.

## Usage

Add `asset_cache` to your `pubspec.yaml`:

```yaml
dependencies:
  asset_cache:
```

Describe assets in your `pubspec.yaml`:

```
  assets:
     - assets/images/
     - assets/json/
```

Set `AssetCache.basePath` to avoid using full asset paths:

```
ImageAssets.instance.basePath = "assets/images/";
```

Load and cache assets using `load`, which returns a `Future<T>`:

```
final image = await ImageAssets.instance.load('sprite.png')
```

See [example](example) and [test](test)

Based on [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html).
