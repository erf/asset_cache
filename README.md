# asset_cache

A flutter package for loading and cache assets in memory.

**asset_cache** can load any types; just inherit from `AssetCache<T>` and give it 
a decoder which decodes a `ByteData` into the correct type `T`.

The library comes with implementations for loading **images**, 
**json** and **strings**, using the following singletons:

- `ImageAssets`
- `ImageAsUint8List`
- `StringAssets` 
- `JsonAssets`

You can set the `AssetCache.basePath` to avoid using full paths for assets.

Remember to add assets in `pubspec.yaml`, like:

```
  assets:
     - assets/images/
     - assets/json/
```

Also, see [test](test) and [example](example).

Based on [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html).
