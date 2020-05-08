# asset_cache

**asset_cache** will load and cache any local asset type `T` given a decoder. 

Using `CachingAssetBundle`, Flutter will not cache binary resources. We therefor do it ourselves, 
using `AssetBundle.load`.

You can create your own asset cache by inheriting from `AssetCache` and give it a decoder or by 
inheriting from `GenericCache` and overriding `loadAsset`.

**asset_cache** comes with singletons for loading various resources:

- ImageAssets
- JsonAssets
- StringAssets
- ByteDataAssets

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

You can set the `AssetCache.basePath` to avoid using full paths for assets:

```
JsonAssets.instance.basePath = "assets/json/";
```

Now load and cache assets using `load`, which returns a `Future<T>`.

```
final json = await JsonAssets.instance.load('sprite.json')
```

See [example](example) and [test](test) for more.

Based on [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html).
