import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/core/api/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:easy_manga_editor/core/error/exceptions.dart';
import 'package:easy_manga_editor/core/error/result.dart';

@singleton
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    ]);
  }

  Future<Result<T>> safeCall<T>(
    Future<T> Function() call,
  ) async {
    try {
      final response = await call();
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(
        NetworkException.fromDioError(e),
      );
    } catch (e, stackTrace) {
      return Result.failure(
        GeneralException(
          e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // GET request
  Future<Result<Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return safeCall(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  // POST request
  Future<Result<Response>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return safeCall(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  // PUT request
  Future<Result<Response>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return safeCall(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  // DELETE request
  Future<Result<Response>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return safeCall(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }
}
