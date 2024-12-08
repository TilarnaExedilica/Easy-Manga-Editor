import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/core/storage/app_storage.dart';
import 'package:easy_manga_editor/core/utils/constants/storage_constants.dart';

@injectable
class AuthGuard extends AutoRouteGuard {
  final AppStorage _storage;

  AuthGuard(this._storage);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final token = await _storage.getString(StorageConstants.tokenKey);

    if (token != null) {
      // allow navigation
      resolver.next(true);
    } else {
      // redirect to login page
      // resolver.redirect(const LoginRoute());
    }
  }
}
