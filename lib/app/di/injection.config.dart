// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i790;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/api/api_client.dart' as _i430;
import '../../core/api/api_module.dart' as _i254;
import '../../core/api/interceptors/auth_interceptor.dart' as _i304;
import '../../core/storage/app_storage.dart' as _i944;
import '../routes/app_router.dart' as _i629;
import '../routes/guards/auth_guard.dart' as _i284;
import '../theme/bloc/theme_bloc.dart' as _i279;
import '../theme/data/theme_preferences.dart' as _i671;
import 'router_module.dart' as _i393;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final routerModule = _$RouterModule();
    final apiModule = _$ApiModule();
    gh.factory<_i279.ThemeBloc>(() => _i279.ThemeBloc());
    gh.singleton<_i790.AutoRouter>(() => routerModule.router);
    gh.singleton<_i430.ApiClient>(() => _i430.ApiClient());
    gh.singletonAsync<_i944.AppStorage>(() => _i944.AppStorage.create());
    gh.singletonAsync<_i304.AuthInterceptor>(() async =>
        apiModule.authInterceptor(await getAsync<_i944.AppStorage>()));
    gh.factoryAsync<_i284.AuthGuard>(
        () async => _i284.AuthGuard(await getAsync<_i944.AppStorage>()));
    gh.factoryAsync<_i671.ThemePreferences>(
        () async => _i671.ThemePreferences(await getAsync<_i944.AppStorage>()));
    gh.singleton<_i629.AppRouter>(
        () => _i629.AppRouter(router: gh<_i790.AutoRouter>()));
    return this;
  }
}

class _$RouterModule extends _i393.RouterModule {}

class _$ApiModule extends _i254.ApiModule {}
