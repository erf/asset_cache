# asset_cache

A library for loading and cache assets, in memory, of generic types.

Inherit from `AssetCache` and give it a decoder, or inherit from `GenericCache` and overload the 
`loadAsset` method.

The library comes with ready to use asset cache implementations as singletons for loading images, 
strings and json files: `ImageAssets`, `ImageAsUint8List`, `StringAssets` and `JsonAssets`.

Set `basePath` to avoid entering full path for assets.

Remember to add assets in `pubspec.yaml` like so:
```
  assets:
     - assets/images/
     - assets/json/
```

See [test](test) and [example](example).

Based on [CachingAssetBundle](https://api.flutter.dev/flutter/services/CachingAssetBundle-class.html).
