import 'package:dicey_quests/src/feature/quests/presentation/catalog_screen.dart';
import 'package:dicey_quests/src/feature/quests/presentation/info_screen.dart';
import 'package:dicey_quests/src/feature/quests/presentation/pyramid_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dicey_quests/src/feature/splash/presentation/screens/splash_screen.dart';
import 'package:dicey_quests/routes/root_navigation_screen.dart';
import 'package:dicey_quests/routes/route_value.dart';

import '../src/feature/quests/presentation/diary_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _catalogNavigatorKey = GlobalKey<NavigatorState>();
final _diaryNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _catalogNavigatorKey,
              path: RouteValue.catalog.path,
              builder: (context, state) => CatalogScreen(key: UniqueKey()),
              routes: <RouteBase>[
                GoRoute(
                  parentNavigatorKey: _catalogNavigatorKey,
                  path: RouteValue.info.path,
                  builder: (context, state) {
                    return const InfoScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: _homeNavigatorKey,
              path: RouteValue.home.path,
              builder: (context, state) => PyramidScreen(key: UniqueKey()),
            ),
            GoRoute(
              parentNavigatorKey: _diaryNavigatorKey,
              path: RouteValue.diary.path,
              builder: (context, state) => DiaryScreen(key: UniqueKey()),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
