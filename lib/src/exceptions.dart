/// Base exception class for asset cache operations
abstract class AssetCacheException implements Exception {
  /// The error message
  final String message;

  /// The asset key that caused the exception
  final String? assetKey;

  /// The original exception that caused the decoding to fail
  final Object? originalException;

  /// The stack trace of the original exception
  final StackTrace? originalStackTrace;

  /// Constructor for [AssetCacheException]
  const AssetCacheException(
    this.message, {
    this.assetKey,
    this.originalException,
    this.originalStackTrace,
  });

  @override
  String toString() {
    if (assetKey != null) {
      return '$runtimeType: $message (asset: $assetKey)';
    }
    return '$runtimeType: $message';
  }
}

/// Exception thrown when an asset cannot be found or loaded
class AssetNotFoundException extends AssetCacheException {
  /// The full path that was attempted to load
  final String? fullPath;

  /// Constructor for [AssetNotFoundException]
  const AssetNotFoundException(
    super.message, {
    this.fullPath,
    super.assetKey,
    super.originalException,
    super.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('AssetNotFoundException: $message');
    if (assetKey != null) {
      buffer.write(' (asset: $assetKey)');
    }
    if (fullPath != null) {
      buffer.write(' (path: $fullPath)');
    }
    if (originalException != null) {
      buffer.write(' (caused by: $originalException)');
    }
    return buffer.toString();
  }
}

/// Exception thrown when an asset cannot be decoded to the expected type
class DecodingException extends AssetCacheException {
  /// Constructor for [DecodingException]
  const DecodingException(
    super.message, {
    super.assetKey,
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
