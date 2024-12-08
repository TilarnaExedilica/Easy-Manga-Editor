import 'package:dio/dio.dart';

/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;
  final StackTrace? stackTrace;

  const AppException(
    this.message, {
    this.code,
    this.data,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

/// Network related exceptions
class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
    this.statusCode,
  });

  factory NetworkException.fromDioError(DioException error) {
    return NetworkException(
      error.message ?? 'Network error occurred',
      code: '${error.response?.statusCode}',
      data: error.response?.data,
      stackTrace: error.stackTrace,
      statusCode: error.response?.statusCode,
    );
  }
}

/// General application exception
class GeneralException extends AppException {
  const GeneralException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Cache related exceptions
class CacheException extends AppException {
  const CacheException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Authentication related exceptions
class AuthException extends AppException {
  const AuthException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Business logic related exceptions
class BusinessException extends AppException {
  const BusinessException(
    super.message, {
    super.code,
    super.data,
    super.stackTrace,
  });
}
