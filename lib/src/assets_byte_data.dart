import 'dart:typed_data';

import 'asset_cache.dart';

/// An asset caches for ByteData
class ByteDataAssets extends AssetCache<ByteData> {
  ByteDataAssets() : super((ByteData data) => Future.value(data));
}
