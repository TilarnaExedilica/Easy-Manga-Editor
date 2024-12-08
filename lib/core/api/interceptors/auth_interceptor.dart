import 'package:dio/dio.dart';
import 'package:easy_manga_editor/core/storage/app_storage.dart';

class AuthInterceptor extends Interceptor {
  final AppStorage _storage;
  static const String _tokenKey = 'auth_token';

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getString(_tokenKey);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh or logout
    }
    return handler.next(err);
  }
}
