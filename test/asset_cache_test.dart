import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MyBundle extends AssetBundle {
  MyBundle();

  @override
  Future<ByteData> load(String key) {
    return Future.value(ByteData(0));
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    return Future.value(null);
  }
}

class MyCache extends GenericCache<String> {
  int counter = 0;

  MyCache() : super();

  @override
  Future<String> loadAsset(String name) {
    counter++;
    return Future.value(name);
  }
}

void main() {
  group("Custom GenericCache MyCache tests", () {
    test('cache and get same value back', () async {
      final cache = MyCache();
      final result = await cache.load("test");
      expect(result, "test");
    });

    test('cache and get same value back twice', () async {
      final cache = MyCache();
      final result1 = await cache.load("test");
      final result2 = await cache.load("test");
      expect(result1, "test");
      expect(result2, "test");
    });

    test('cache and get two different values', () async {
      final cache = MyCache();
      final result1 = await cache.load("test1");
      final result2 = await cache.load("test2");
      expect(result1, "test1");
      expect(result2, "test2");
    });

    test('only cache once', () async {
      final cache = MyCache();
      final result1 = await cache.load("test");
      final result2 = await cache.load("test");
      final result3 = await cache.load("test");
      expect(result1, "test");
      expect(result2, "test");
      expect(result3, "test");
      expect(cache.counter, 1);
    });

    test('only cache twice', () async {
      final cache = MyCache();
      final result1 = await cache.load("test");
      final result2 = await cache.load("HELLO");
      final result3 = await cache.load("test");
      expect(result1, "test");
      expect(result2, "HELLO");
      expect(result3, "test");
      expect(cache.counter, 2);
    });
  });
}
