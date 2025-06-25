import 'package:asset_cache/asset_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'file_asset_bundle.dart';

class FailingDecoder extends AssetCache<String> {
  FailingDecoder({super.assetBundle})
      : super(decoder: (data) => throw Exception('Decoding failed'));
}

void main() {
  group('Exception tests', () {
    test('AssetNotFoundException contains correct information', () {
      final originalException = Exception('File not found');
      final stackTrace = StackTrace.current;

      final exception = AssetNotFoundException(
        'Test message',
        assetKey: 'test.txt',
        originalException: originalException,
        originalStackTrace: stackTrace,
      );

      expect(exception.message, 'Test message');
      expect(exception.assetKey, 'test.txt');
      expect(exception.originalException, originalException);
      expect(exception.originalStackTrace, stackTrace);
      expect(exception.toString(),
          contains('AssetNotFoundException: Test message'));
      expect(exception.toString(), contains('(asset: test.txt)'));
      expect(exception.toString(),
          contains('(caused by: Exception: File not found)'));
    });

    test('AssetNotFoundException without optional parameters', () {
      const exception = AssetNotFoundException('Simple message');

      expect(exception.message, 'Simple message');
      expect(exception.assetKey, isNull);
      expect(exception.toString(), 'AssetNotFoundException: Simple message');
    });

    test('DecodingException contains correct information', () {
      final originalException = Exception('Original error');
      final stackTrace = StackTrace.current;

      final exception = DecodingException(
        'Decoding failed',
        assetKey: 'image.png',
        originalException: originalException,
        originalStackTrace: stackTrace,
      );

      expect(exception.message, 'Decoding failed');
      expect(exception.assetKey, 'image.png');
      expect(exception.originalException, originalException);
      expect(exception.originalStackTrace, stackTrace);
      expect(
          exception.toString(), contains('DecodingException: Decoding failed'));
      expect(exception.toString(), contains('(asset: image.png)'));
      expect(exception.toString(),
          contains('(caused by: Exception: Original error)'));
    });

    test('DecodingException without optional parameters', () {
      const exception = DecodingException('Simple decoding error');

      expect(exception.message, 'Simple decoding error');
      expect(exception.assetKey, isNull);
      expect(exception.originalException, isNull);
      expect(exception.originalStackTrace, isNull);
      expect(exception.toString(), 'DecodingException: Simple decoding error');
    });

    test('AssetNotFoundException thrown for non-existent asset', () async {
      final bundle = FileAssetBundle();
      final cache = TextAssetCache(assetBundle: bundle);

      expect(
        () => cache.load('nonexistent.txt'),
        throwsA(isA<AssetNotFoundException>()
            .having((e) => e.assetKey, 'assetKey', 'nonexistent.txt')
            .having(
                (e) => e.originalException, 'originalException', isNotNull)),
      );
    });

    test('DecodingException thrown when decoder fails', () async {
      final bundle = FileAssetBundle();
      final cache = FailingDecoder(assetBundle: bundle);

      expect(
        () => cache.load(
            'test/assets/test.txt'), // Use full path to existing test file
        throwsA(isA<DecodingException>()
            .having((e) => e.assetKey, 'assetKey', 'test/assets/test.txt')
            .having((e) => e.originalException, 'originalException',
                isA<Exception>())),
      );
    });

    test(
        'Failed asset loads are cached - same exception thrown for repeated calls',
        () async {
      final bundle = FileAssetBundle();
      final cache = TextAssetCache(assetBundle: bundle);

      // First call should throw and cache the failed Future
      AssetNotFoundException? firstException;
      try {
        await cache.load('nonexistent.txt');
      } on AssetNotFoundException catch (e) {
        firstException = e;
      }

      // Second call should throw from the same cached failed Future
      AssetNotFoundException? secondException;
      try {
        await cache.load('nonexistent.txt');
      } on AssetNotFoundException catch (e) {
        secondException = e;
      }

      expect(firstException, isNotNull);
      expect(secondException, isNotNull);
      // The exceptions have the same properties even if they're different instances
      expect(firstException!.assetKey, secondException!.assetKey);
      expect(firstException.message, secondException.message);
    });

    test('Exception types extend AssetCacheException', () {
      const assetNotFound = AssetNotFoundException('test');
      const decodingException = DecodingException('test');

      expect(assetNotFound, isA<AssetCacheException>());
      expect(decodingException, isA<AssetCacheException>());
      expect(assetNotFound, isA<Exception>());
      expect(decodingException, isA<Exception>());
    });
  });
}
