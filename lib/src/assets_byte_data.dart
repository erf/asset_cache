import 'dart:typed_data';

import 'asset_cache.dart';

/// A singleton asset caches for ByteData
class ByteDataAssets extends AssetCache<ByteData> {
  static final _decoder = (ByteData data) => Future.value(data);

  ByteDataAssets._privateConstructor() : super(_decoder);

  static final ByteDataAssets instance = ByteDataAssets._privateConstructor();
}
