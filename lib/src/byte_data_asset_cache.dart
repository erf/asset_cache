import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// Asset caches for ByteData
class ByteDataAssetCache extends AssetCache<ByteData> {
  ByteDataAssetCache({
    String? basePath,
    AssetBundle? bundle,
  }) : super(
          decoder: (ByteData data) => data,
          basePath: basePath,
          bundle: bundle,
        );
}
