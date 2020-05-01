# asset_cache

A library for loading and caching assets of generic types.

Inherit from `AssetCache` and give it a decoder, or inherit from `GenericCache` and overload the 
`loadAsset` method.

The library comes with ready to use asset cache implementations as singletons for loading images, 
strings and json files. 

See `ImageAssets`, `ImageAsUint8List`, `StringAssets` and `JsonAssets`.

This was based on `CachingAssetBundle`.

See [example](example).
