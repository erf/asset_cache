import 'package:asset_cache/asset_cache.dart';
import 'package:flutter_test/flutter_test.dart';

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
  group('Custom GenericCache MyCache tests', () {
    test('cache and get same value back', () async {
      final cache = MyCache();
      final result = await cache.load('test');
      expect(result, 'test');
    });

    test('cache and get same value back twice', () async {
      final cache = MyCache();
      final result1 = await cache.load('test');
      final result2 = await cache.load('test');
      expect(result1, 'test');
      expect(result2, 'test');
    });

    test('cache and get two different values', () async {
      final cache = MyCache();
      final result1 = await cache.load('test1');
      final result2 = await cache.load('test2');
      expect(result1, 'test1');
      expect(result2, 'test2');
    });

    test('only cache once', () async {
      final cache = MyCache();
      final result1 = await cache.load('test');
      final result2 = await cache.load('test');
      final result3 = await cache.load('test');
      expect(result1, 'test');
      expect(result2, 'test');
      expect(result3, 'test');
      expect(cache.counter, 1);
    });

    test('only cache twice', () async {
      final cache = MyCache();
      final result1 = await cache.load('test');
      final result2 = await cache.load('HELLO');
      final result3 = await cache.load('test');
      expect(result1, 'test');
      expect(result2, 'HELLO');
      expect(result3, 'test');
      expect(cache.counter, 2);
    });
  });

  group('Cache management methods', () {
    test('clear removes all cached items', () async {
      final cache = MyCache();
      await cache.load('test1');
      await cache.load('test2');
      expect(cache.size, 2);
      expect(cache.contains('test1'), true);
      expect(cache.contains('test2'), true);

      cache.clear();
      expect(cache.size, 0);
      expect(cache.contains('test1'), false);
      expect(cache.contains('test2'), false);
    });

    test('remove removes specific cached item', () async {
      final cache = MyCache();
      await cache.load('test1');
      await cache.load('test2');
      expect(cache.size, 2);

      final removed = cache.remove('test1');
      expect(removed, true);
      expect(cache.size, 1);
      expect(cache.contains('test1'), false);
      expect(cache.contains('test2'), true);
    });

    test('remove returns false for non-existent item', () {
      final cache = MyCache();
      final removed = cache.remove('nonexistent');
      expect(removed, false);
    });

    test('contains returns correct values', () async {
      final cache = MyCache();
      expect(cache.contains('test'), false);

      await cache.load('test');
      expect(cache.contains('test'), true);
      expect(cache.contains('other'), false);
    });

    test('size returns correct count', () async {
      final cache = MyCache();
      expect(cache.size, 0);

      await cache.load('test1');
      expect(cache.size, 1);

      await cache.load('test2');
      expect(cache.size, 2);

      await cache.load('test1'); // Should not increase size (already cached)
      expect(cache.size, 2);
    });

    test('cache operations work together', () async {
      final cache = MyCache();

      // Load some items
      await cache.load('item1');
      await cache.load('item2');
      await cache.load('item3');
      expect(cache.size, 3);

      // Remove one item
      expect(cache.remove('item2'), true);
      expect(cache.size, 2);
      expect(cache.contains('item1'), true);
      expect(cache.contains('item2'), false);
      expect(cache.contains('item3'), true);

      // Clear all
      cache.clear();
      expect(cache.size, 0);
      expect(cache.contains('item1'), false);
      expect(cache.contains('item3'), false);
    });

    test('loading after removal creates new cache entry', () async {
      final cache = MyCache();

      // Load and cache an item
      await cache.load('test');
      expect(cache.counter, 1);
      expect(cache.contains('test'), true);

      // Remove it
      cache.remove('test');
      expect(cache.contains('test'), false);

      // Load again - should call loadAsset again
      await cache.load('test');
      expect(cache.counter, 2);
      expect(cache.contains('test'), true);
    });
  });
}
