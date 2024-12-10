import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/app/l10n/tr_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/screens/home/home_page.dart';
import 'package:easy_manga_editor/screens/studio/studio_page.dart';

part 'app_router.gr.dart';

enum AppRoute {
  home(path: '/home', name: TrKeys.home),
  studio(path: '/studio', name: TrKeys.studio);

  final String path;
  final String name;

  const AppRoute({
    required this.path,
    required this.name,
  });
}

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.router});

  final AutoRouter router;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: AppRoute.home.path,
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: AppRoute.studio.path,
          page: StudioRoute.page,
        ),
      ];
}
