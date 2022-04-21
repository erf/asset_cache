import 'dart:io';

import 'package:flutter/services.dart';

class FileAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) {
    return File(key).readAsBytes().then((value) => value.buffer.asByteData());
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}
