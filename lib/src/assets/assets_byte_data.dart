import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../asset_cache.dart';

/// An asset caches for ByteData
class ByteDataAssets extends AssetCache<ByteData> {
  ByteDataAssets({String basePath, AssetBundle bundle})
      : super((ByteData data) => Future.value(data),
            basePath: basePath, bundle: bundle);
}
