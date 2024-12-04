import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/src/feature/pond/presentation/add_pond_screen.dart';
import 'package:pond_care/src/feature/pond/presentation/details_screen.dart';

import 'package:pond_care/src/feature/pond/presentation/history_screen.dart';

import 'package:pond_care/src/feature/pond/presentation/choose_screen.dart';

import 'package:pond_care/src/feature/pond/presentation/home_screen.dart';
import 'package:pond_care/src/feature/pond/presentation/task_screen.dart';
import 'package:pond_care/src/feature/splash/presentation/screens/splash_screen.dart';
import 'package:pond_care/routes/root_navigation_screen.dart';
import 'package:pond_care/routes/route_value.dart';

import '../src/feature/pond/models/pond.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

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
              parentNavigatorKey: _homeNavigatorKey,
              path: RouteValue.home.path,
              builder: (context, state) => HomeScreen(key: UniqueKey()),
              routes: <RouteBase>[
                GoRoute(
                  parentNavigatorKey: _homeNavigatorKey,
                  path: RouteValue.addPond.path,
                  builder: (context, state) {
                    return const AddPondScreen();
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _homeNavigatorKey,
                      path: RouteValue.choose.path,
                      builder: (context, state) {
                        final type = state.extra! as ChooseType;
                        return ChooseScreen(
                          type: type,
                          key: UniqueKey(),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _homeNavigatorKey,
                  path: RouteValue.details.path,
                  builder: (context, state) {
                    return DetailsScreen(
                      pondd: state.extra! as Pond,
                      key: UniqueKey(),
                    );
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _homeNavigatorKey,
                      path: RouteValue.addPond.path,
                      builder: (context, state) {
                        return AddPondScreen(
                          pond: state.extra! as Pond?,
                          key: UniqueKey(),
                        );
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _homeNavigatorKey,
                          path: RouteValue.choose.path,
                          builder: (context, state) {
                            final type = state.extra! as ChooseType;
                            return ChooseScreen(
                              type: type,
                              key: UniqueKey(),
                            );
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      parentNavigatorKey: _homeNavigatorKey,
                      path: RouteValue.tasks.path,
                      builder: (context, state) {
                        final pond = state.extra! as Pond;
                        return TaskScreen(
                          key: UniqueKey(),
                          pond: pond,
                        );
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _homeNavigatorKey,
                          path: RouteValue.history.path,
                          builder: (context, state) {
                            return HistoryScreen(
                              key: UniqueKey(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
