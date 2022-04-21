## [2.0.0] - 21 April 2022
- make AssetDecoder return FutureOr and simplify decoders
- make 'decoder' a named constructor parameter
- rename bundle -> assetBundle
- improve docs
- add tests for all cache types

## [1.0.1] - 13 February 2022
- make members final 
- cleanup 
- update license name / year

## [1.0.0+1] - 12 March 2021
- pubspec description

## [1.0.0] - 12 March 2021
- migrate to null-safety

## [0.3.0+2] - 12 March 2021
- update README

## [0.3.0+1] - 12 March 2021
- update README

## [0.3.0] - 12 March 2021
- breaking changes !!
- replaced Singeltons with public constructors
- pass optional basePath and bundle in constructors
- don't make decoders static
- rename special asset cache implementations to {Type}AssetCache
- update example to use ImageAssetCache
- use path to join basePath and asset name
- code cleanup

## [0.2.3]
- update README

## [0.2.2]
- update README

## [0.2.1]
- update pubspec.yaml
- format

## [0.2.0]
- split up asset_cache in multiple files
- changed Uint8List decoder class to use ByteData
- updated README

## [0.1.4]
- update README | format

## [0.1.3]
- update README

## [0.1.2]
- update README

## [0.1.1]
- update README

## [0.1.0]
- initial release
- generic asset cache for loading assets given a decoder
- a set of asset cache implementations for images, json files and strings
- a generic cache class
- tests
- examples
