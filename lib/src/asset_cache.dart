import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A generic cache of type [T]
abstract class GenericCache<T> {
  /// a map for caching types of T in memory
  Map<String, Future<T>> _cache = {};

  /// optional base path so you don't have to type full path
  String basePath;

  /// override this to load a resource given a key
  Future<T> loadAsset(String key);

  /// return resource if in cache, if not call [loadAsset]
  Future<T> load(String key) => _cache.putIfAbsent(key, () => loadAsset(key));
}

/// The asset decoder declaration
///
/// Given a [ByteData] returns a type T
typedef AssetDecoder<T> = Future<T> Function(ByteData);

/// A generic cache for loading assets of type [T] given an [AssetDecoder]
class AssetCache<T> extends GenericCache<T> {
  /// decode asset bytes to type T
  AssetDecoder<T> decoder;

  /// optional asset bundle
  AssetBundle bundle;

  /// add asset decoder in constructor, and optional bundle
  AssetCache(this.decoder, {this.bundle});

  /// load an asset from a bundle given a key and optional base path and
  /// decode the asset using a given decoder
  Future<T> loadAsset(String name) async {
    final String key = basePath == null ? name : basePath + name;
    if (bundle != null) {
      return await decoder(await bundle.load(key));
    } else {
      return await decoder(await rootBundle.load(key));
    }
  }
}

/// A singleton asset caches for images
class ImageAssets extends AssetCache<Image> {
  static final _decoder =
      (ByteData data) => decodeImageFromList(data.buffer.asUint8List());

  ImageAssets._privateConstructor() : super(_decoder);

  static final ImageAssets instance = ImageAssets._privateConstructor();
}

/// A singleton asset caches for images as Uint8List
class ImageAsUint8List extends AssetCache<Uint8List> {
  static final _decoder =
      (ByteData data) => Future.value(data.buffer.asUint8List());

  ImageAsUint8List._privateConstructor() : super(_decoder);

  static final ImageAsUint8List instance =
      ImageAsUint8List._privateConstructor();
}

/// A singleton asset caches for strings
class StringAssets extends AssetCache<String> {
  static final _decoder =
      (ByteData data) => Future.value(utf8.decode(data.buffer.asUint8List()));

  StringAssets._privateConstructor() : super(_decoder);

  static final StringAssets instance = StringAssets._privateConstructor();
}

/// A singleton asset caches for json files
class JsonAssets extends AssetCache<dynamic> {
  static final _decoder = (ByteData data) =>
      Future.value(jsonDecode(utf8.decode(data.buffer.asUint8List())));

  JsonAssets._privateConstructor() : super(_decoder);

  static final JsonAssets instance = JsonAssets._privateConstructor();
}
