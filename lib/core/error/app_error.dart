import 'package:tower_desktop_app/core/network/api_client.dart';

/// Error types for categorizing application errors
enum AppErrorType {
  /// Network connectivity issues
  network,

  /// Server-side errors (5xx)
  server,

  /// Validation/bad request errors (400)
  validation,

  /// Authentication/authorization errors (401, 403)
  auth,

  /// Resource not found (404)
  notFound,

  /// Unknown/unclassified errors
  unknown,
}

/// Standardized application error
///
/// Provides consistent error handling across the application.
class AppError implements Exception {
  final AppErrorType type;
  final String message;
  final String? code;
  final int? statusCode;
  final StackTrace? stackTrace;

  const AppError({
    required this.type,
    required this.message,
    this.code,
    this.statusCode,
    this.stackTrace,
  });

  /// Create AppError from ApiException
  factory AppError.fromApiException(ApiException e, [StackTrace? stackTrace]) {
    return ErrorHandler.handle(e, stackTrace);
  }

  /// Get user-friendly error message
  String get userMessage {
    switch (type) {
      case AppErrorType.network:
        return '网络连接失败，请检查网络设置';
      case AppErrorType.server:
        return '服务器繁忙，请稍后重试';
      case AppErrorType.validation:
        return message.isNotEmpty ? message : '请求参数错误';
      case AppErrorType.auth:
        return '登录已过期，请重新登录';
      case AppErrorType.notFound:
        return '请求的资源不存在';
      case AppErrorType.unknown:
        return message.isNotEmpty ? message : '发生未知错误';
    }
  }

  /// Check if error is retryable
  bool get isRetryable {
    switch (type) {
      case AppErrorType.network:
      case AppErrorType.server:
        return true;
      case AppErrorType.validation:
      case AppErrorType.auth:
      case AppErrorType.notFound:
      case AppErrorType.unknown:
        return false;
    }
  }

  @override
  String toString() =>
      'AppError(type: $type, message: $message, code: $code, statusCode: $statusCode)';
}

/// Error handler utility for transforming exceptions
class ErrorHandler {
  ErrorHandler._();

  /// Transform ApiException to AppError
  static AppError handle(ApiException e, [StackTrace? stackTrace]) {
    final type = _mapStatusCodeToType(e.statusCode);
    return AppError(
      type: type,
      message: e.message,
      statusCode: e.statusCode,
      stackTrace: stackTrace,
    );
  }

  /// Transform any exception to AppError
  static AppError handleAny(Object e, [StackTrace? stackTrace]) {
    if (e is ApiException) {
      return handle(e, stackTrace);
    }
    if (e is AppError) {
      return e;
    }
    return AppError(
      type: AppErrorType.unknown,
      message: e.toString(),
      stackTrace: stackTrace,
    );
  }

  /// Map HTTP status code to AppErrorType
  static AppErrorType _mapStatusCodeToType(int? statusCode) {
    if (statusCode == null || statusCode == 0) {
      return AppErrorType.network;
    }

    if (statusCode == 400) {
      return AppErrorType.validation;
    }

    if (statusCode == 401 || statusCode == 403) {
      return AppErrorType.auth;
    }

    if (statusCode == 404) {
      return AppErrorType.notFound;
    }

    if (statusCode >= 500 && statusCode < 600) {
      return AppErrorType.server;
    }

    return AppErrorType.unknown;
  }
}
