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

  group('Preload functionality', () {
    test('preload loads multiple assets concurrently and returns results',
        () async {
      final cache = MyCache();
      final keys = [
        'item1',
        'item2',
        'item3'
      ]; // MyCache just returns the key as value

      // Preload multiple assets
      final results = await cache.preload(keys);

      // Should return the loaded assets
      expect(results, isNotNull);
      expect(results.length, 3);
      expect(results, contains('item1'));
      expect(results, contains('item2'));
      expect(results, contains('item3'));

      // All assets should be loaded and cached
      expect(cache.size, 3);
      expect(cache.contains('item1'), true);
      expect(cache.contains('item2'), true);
      expect(cache.contains('item3'), true);
      expect(cache.counter, 3);

      // Subsequent loads should not trigger loadAsset again
      await cache.load('item1');
      await cache.load('item2');
      await cache.load('item3');
      expect(cache.counter, 3); // Still 3, no additional loads
    });

    test('preload with empty list returns empty results', () async {
      final cache = MyCache();

      final results = await cache.preload([]);

      expect(results, isEmpty);
      expect(cache.size, 0);
      expect(cache.counter, 0);
    });

    test('preload with single item works', () async {
      final cache = MyCache();

      final results = await cache.preload(['single']);

      expect(results.length, 1);
      expect(results.first, 'single');
      expect(cache.size, 1);
      expect(cache.contains('single'), true);
      expect(cache.counter, 1);
    });

    test('preload with duplicate keys only loads once per key', () async {
      final cache = MyCache();
      final keys = ['dup1', 'dup2', 'dup1', 'dup2', 'dup1'];

      final results = await cache.preload(keys);

      // Should return all requested items (including duplicates)
      expect(results.length, 5);
      expect(results.where((r) => r == 'dup1').length, 3);
      expect(results.where((r) => r == 'dup2').length, 2);

      // But only unique keys should be loaded/cached
      expect(cache.size, 2);
      expect(cache.contains('dup1'), true);
      expect(cache.contains('dup2'), true);
      expect(cache.counter, 2);
    });

    test('preload mixed with regular load operations', () async {
      final cache = MyCache();

      // Load one asset normally
      await cache.load('normal');
      expect(cache.counter, 1);

      // Preload some assets including the already loaded one
      final results = await cache.preload(['normal', 'preload1', 'preload2']);

      // Should return all requested assets
      expect(results.length, 3);
      expect(results, contains('normal'));
      expect(results, contains('preload1'));
      expect(results, contains('preload2'));

      // Should have 3 total assets, but only 2 additional loads
      expect(cache.size, 3);
      expect(cache.counter, 3);
      expect(cache.contains('normal'), true);
      expect(cache.contains('preload1'), true);
      expect(cache.contains('preload2'), true);
    });

    test('preload throws PreLoadingAssetsNotFoundException on failure',
        () async {
      final cache = FailingOnSpecificKeysCache(['fail1']);

      expect(
        () => cache.preload(['success1', 'fail1', 'success2']),
        throwsA(isA<PreLoadingAssetsNotFoundException>()
            .having((e) => e.assetKeys, 'assetKeys', contains('fail1'))
            .having(
                (e) => e.originalException, 'originalException', isNotNull)),
      );
    });

    test('preload maintains order of results', () async {
      final cache = MyCache();
      final keys = ['third', 'first', 'second', 'first', 'third'];

      final results = await cache.preload(keys);

      // Results should maintain the order of the input keys
      expect(results.length, 5);
      expect(results[0], 'third');
      expect(results[1], 'first');
      expect(results[2], 'second');
      expect(results[3], 'first');
      expect(results[4], 'third');
    });

    test('preload integrates with cache management methods', () async {
      final cache = MyCache();
      final keys = ['asset1', 'asset2', 'asset3'];

      // Preload assets
      await cache.preload(keys);
      expect(cache.size, 3);

      // Remove one asset
      expect(cache.remove('asset2'), true);
      expect(cache.size, 2);
      expect(cache.contains('asset2'), false);

      // Preload again should reload the removed asset
      await cache.preload(['asset2']);
      expect(cache.size, 3);
      expect(cache.contains('asset2'), true);
      expect(cache.counter, 4); // 3 initial + 1 reload

      // Clear all
      cache.clear();
      expect(cache.size, 0);

      // Preload after clear should reload everything
      await cache.preload(keys);
      expect(cache.size, 3);
      expect(cache.counter, 7); // 4 previous + 3 reload
    });
  });
}

class FailingOnSpecificKeysCache extends GenericCache<String> {
  final Set<String> failingKeys;
  int counter = 0;

  FailingOnSpecificKeysCache(List<String> failingKeys)
      : failingKeys = Set.from(failingKeys),
        super();

  @override
  Future<String> loadAsset(String name) {
    counter++;
    if (failingKeys.contains(name)) {
      throw Exception('Simulated failure for $name');
    }
    return Future.value(name);
  }
}
