import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/analyzed_waste/analyzed_waste.dart';
import '../../models/article/article.dart';
import '../../models/challenge/challenge.dart';
import '../../models/guide/guide.dart';
import '../features/article/pages/article_page.dart';
import '../features/bookmarks/pages/bookmarks_page.dart';
import '../features/challenge/pages/challenge_page.dart';
import '../features/community/pages/community_page.dart';
import '../features/community/pages/search_page.dart';
import '../features/guide/pages/guide_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/profile/pages/attributions_page.dart';
import '../features/profile/pages/help_page.dart';
import '../features/profile/pages/notifications_page.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/profile/pages/settings_page.dart';
import '../features/user_analyzed_waste/pages/analyzed_waste_detail_page.dart';
import '../features/user_analyzed_waste/pages/user_analyzed_waste_page.dart';
import '../features/waste_analysis/pages/waste_analysis_page.dart';
import '../shared/app_wrapper.dart';
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
        routes: [
          GoRoute(
            path: RoutePaths.analyze,
            name: RouteNames.analyze,
            parentNavigatorKey: _rootNavigatorKey,
            pageBuilder: (BuildContext context, GoRouterState state) => slideUpPageTransition(
              context: context,
              state: state,
              child: const WasteAnalysisPage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.challenge,
            name: RouteNames.challenge,
            builder: (BuildContext context, GoRouterState state) {
              return ChallengePage(challenge: state.extra as Challenge);
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
                      GoRoute(
                        path: RoutePaths.guide,
                        name: RouteNames.guide,
                        builder: (BuildContext context, GoRouterState state) {
                          return GuidePage(guide: state.extra as Guide);
                        },
                      ),
                      GoRoute(
                        path: RoutePaths.search,
                        name: RouteNames.search,
                        parentNavigatorKey: _rootNavigatorKey,
                        pageBuilder: (BuildContext context, GoRouterState state) => fadePageTransition<void>(
                          context: context,
                          state: state,
                          child: const SearchPage(),
                        ),
                      ),
                      GoRoute(
                        path: RoutePaths.bookmarks,
                        name: RouteNames.bookmarks,
                        builder: (BuildContext context, GoRouterState state) => const BookmarksPage(),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.profile,
                    name: RouteNames.profile,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ProfilePage();
                    },
                    routes: [
                      GoRoute(
                        path: RoutePaths.notifications,
                        name: RouteNames.notifications,
                        builder: (BuildContext context, GoRouterState state) => const NotificationsPage(),
                      ),
                      GoRoute(
                        path: RoutePaths.settings,
                        name: RouteNames.settings,
                        builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
                      ),
                      GoRoute(
                        path: RoutePaths.help,
                        name: RouteNames.help,
                        builder: (BuildContext context, GoRouterState state) => const HelpPage(),
                        routes: [
                          GoRoute(
                            path: RoutePaths.attributions,
                            name: RouteNames.attributions,
                            parentNavigatorKey: _rootNavigatorKey,
                            pageBuilder: (BuildContext context, GoRouterState state) => slideUpPageTransition<void>(
                              context: context,
                              state: state,
                              child: const AttributionsPage(),
                            ),
                          ),
                        ],
                      ),
                      GoRoute(
                          path: RoutePaths.analyzedWaste,
                          name: RouteNames.analyzedWaste,
                          builder: (BuildContext context, GoRouterState state) => const UserAnalyzedWastePage(),
                          routes: [
                            GoRoute(
                              path: RoutePaths.analyzedWasteDetail,
                              name: RouteNames.analyzedWasteDetail,
                              parentNavigatorKey: _rootNavigatorKey,
                              pageBuilder: (BuildContext context, GoRouterState state) => slideUpPageTransition<void>(
                                context: context,
                                state: state,
                                child: AnalyzedWasteDetailPage(analyzedWaste: state.extra as AnalyzedWaste),
                              ),
                            ),
                          ]),
                    ],
                  ),
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
