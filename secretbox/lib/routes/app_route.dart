import 'package:auto_route/auto_route.dart';
import 'package:secretbox/features/game/presentation/pages/home_page.dart';

part 'app_route.gr.dart';
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  RouteType get defaultRouteType =>
      const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}