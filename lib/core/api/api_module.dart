import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/core/api/interceptors/auth_interceptor.dart';
import 'package:easy_manga_editor/core/storage/app_storage.dart';

@module
abstract class ApiModule {
  @singleton
  AuthInterceptor authInterceptor(AppStorage storage) =>
      AuthInterceptor(storage);
}
