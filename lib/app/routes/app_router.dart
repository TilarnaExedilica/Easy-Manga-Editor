import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/screens/home/home_page.dart';
import 'package:easy_manga_editor/screens/studio/studio_page.dart';

part 'app_router.gr.dart';

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
          path: '/',
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/studio',
          page: StudioRoute.page,
        ),
      ];
}
