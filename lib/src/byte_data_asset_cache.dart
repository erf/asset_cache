import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for ByteData
class ByteDataAssetCache extends AssetCache<ByteData> {
  ByteDataAssetCache({String? basePath, AssetBundle? bundle})
      : super((ByteData data) => Future.value(data),
            basePath: basePath, bundle: bundle);
}
