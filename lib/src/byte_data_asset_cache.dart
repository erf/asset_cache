import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset cache for ByteData
class ByteDataAssetCache extends AssetCache<ByteData> {
  ByteDataAssetCache({
    super.basePath,
    super.assetBundle,
  }) : super(decoder: (ByteData data) => data);
}
