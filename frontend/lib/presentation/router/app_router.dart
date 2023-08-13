import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/features/article/pages/article_page.dart';
import 'package:know_waste/presentation/features/community/pages/community_page.dart';
import 'package:know_waste/presentation/shared/app_wrapper.dart';

import '../../models/article/article.dart';
import '../features/home/pages/home_page.dart';
import '../features/waste_analysis/pages/waste_analysis_page.dart';
import '../features/welcome/pages/welcome_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

class AppRouter {
  AppRouter(WidgetRef ref) {
    appRouter = _getAppRouter(ref);
  }

  // A function to set the initial location for the router
  String setInitialLocation(String location) => initialLocation = location;

  // Declare the appRouter variable of type GoRouter
  late GoRouter appRouter;

  // Define the initial location for the router
  static String initialLocation = RoutePaths.home;

  // Create a key for the root navigator
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  // Define the main app router using the GoRouter library
  GoRouter _getAppRouter(WidgetRef ref) => GoRouter(
        // refreshListenable: ref.watch(authStateProvider),
        navigatorKey: _rootNavigatorKey,
        initialLocation: initialLocation,
        debugLogDiagnostics: true,
        // redirect: (context, state) {
        //   final loggedIn = ref.watch(authStateProvider).loggedIn;
        //   if (!loggedIn) {
        //     // Redirect to the welcome page if the user is not logged in
        //     if (state.subloc != '/welcome') {
        //       return '/welcome';
        //     }
        //     return null;
        //   }
        //   return null;
        // },
        routes: [
          GoRoute(
            path: RoutePaths.welcome,
            name: RouteNames.welcome,
            builder: (context, state) => const WelcomePage(),
          ),
          GoRoute(
            path: RoutePaths.analyze,
            name: RouteNames.analyze,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return const WasteAnalysisPage();
            },
          ),
          StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              return AppWrapper(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.home,
                    name: RouteNames.home,
                    builder: (BuildContext context, GoRouterState state) {
                      return const HomePage();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/scan',
                    name: 'scan',
                    builder: (BuildContext context, GoRouterState state) {
                      return Container();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: RoutePaths.community,
                      name: RouteNames.community,
                      builder: (BuildContext context, GoRouterState state) {
                        return const CommunityPage();
                      },
                      routes: [
                        GoRoute(
                          path: RoutePaths.article,
                          name: RouteNames.article,
                          builder: (BuildContext context, GoRouterState state) {
                            return ArticlePage(article: state.extra as Article);
                          },
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ],
      );
}

// A custom transition that slides the page up
CustomTransitionPage slideUpPageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: const Offset(0.0, 0),
      ).chain(CurveTween(curve: Curves.ease)).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    ),
  );
}

// A custom transition that fades the page
CustomTransitionPage fadePageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    opaque: false,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
