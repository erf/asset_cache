/// Base exception class for asset cache operations
abstract class AssetCacheException implements Exception {
  /// The error message
  final String message;

  /// The original exception that caused the decoding to fail
  final Object? originalException;

  /// The stack trace of the original exception
  final StackTrace? originalStackTrace;

  /// Constructor for [AssetCacheException]
  const AssetCacheException(
    this.message, {
    this.originalException,
    this.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('AssetCacheException: $message');
    if (originalException != null) {
      buffer.write(' (caused by: $originalException)');
    }
    if (originalStackTrace != null) {
      buffer.write('\nStack trace: $originalStackTrace');
    }
    return buffer.toString();
  }
}

/// Exception thrown when an asset cannot be found or loaded
class AssetNotFoundException extends AssetCacheException {
  /// The asset key that caused the exception
  final String? assetKey;

  /// Constructor for [AssetNotFoundException]
  const AssetNotFoundException(
    super.message, {
    this.assetKey,
    super.originalException,
    super.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('AssetNotFoundException: $message');
    if (assetKey != null) {
      buffer.write(' (asset: $assetKey)');
    }
    if (originalException != null) {
      buffer.write(' (caused by: $originalException)');
    }
    return buffer.toString();
  }
}

/// Exception thrown when an asset cannot be decoded to the expected type
class DecodingException extends AssetCacheException {
  /// The asset key that caused the exception
  final String? assetKey;

  /// Constructor for [DecodingException]
  const DecodingException(
    super.message, {
    this.assetKey,
    super.originalException,
    super.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('DecodingException: $message');
    if (assetKey != null) {
      buffer.write(' (asset: $assetKey)');
    }
    if (originalException != null) {
      buffer.write(' (caused by: $originalException)');
    }
    return buffer.toString();
  }
}

class PreLoadingAssetsNotFoundException extends AssetCacheException {
  /// The list of asset keys that were not found
  final List<String> assetKeys;

  /// Constructor for [PreLoadingAssetsNotFoundException]
  const PreLoadingAssetsNotFoundException(
    super.message, {
    required this.assetKeys,
    super.originalException,
    super.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('PreLoadingAssetsNotFoundException: $message');
    if (assetKeys.isNotEmpty) {
      buffer.write(' (missing assets: ${assetKeys.join(', ')})');
    }
    if (originalException != null) {
      buffer.write(' (caused by: $originalException)');
    }
    return buffer.toString();
  }
}
