import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/routing/widgets/BottomNavigationBarItem.dart';
import 'package:dash/routing/widgets/ScaffoldWithBottomNavBar.dart';
import 'package:dash/screens/errorScreen.dart';
import 'package:dash/screens/landing/loginScreen.dart';
import 'package:dash/screens/mainScreens/dashboardScreen.dart';
import 'package:dash/state/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  // private navigators
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  final tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: Constants.dashboardRoute,
      icon: const Icon(Icons.home),
      webIcon: Icons.home,
      backgroundColor: ColorsHelper.appBar,
      label: Constants.dashboardName,
    ),

    ScaffoldWithNavBarTabItem(
      initialLocation: Constants.profileRoute,
      icon: const Icon(Icons.person),
      webIcon: Icons.person,
      backgroundColor: ColorsHelper.appBar,
      label: Constants.profileName,
    ),
  ];

  final authState = ref.watch(currentUserProvider);
  return GoRouter(
      initialLocation: Constants.loginRoute,
      navigatorKey: rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
          },
          routes: [
            GoRoute(
              path: Constants.dashboardRoute,
              name: Constants.dashboardName,
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen()),
            ),
          ],
        ),
        GoRoute(
            path: Constants.loginRoute,
            name: Constants.loginName,
            builder: (context, state) => const LoginScreen()),
      ],

      redirect: (context, state) {
        // If our async state is loading, don't perform redirects, yet
        if (authState.isLoading || authState.hasError) return null;

        // Here we guarantee that hasData == true, i.e. we have a readable value

        // This has to do with how the FirebaseAuth SDK handles the "log-in" state
        // Returning `null` means "we are not authorized"
        final isAuth = authState.valueOrNull != null;

        final isLogin = state.location == Constants.loginRoute;
        if (isLogin) {
          return isAuth ? Constants.dashboardRoute : Constants.loginRoute;
        }

        final isLoggingIn = state.location == Constants.loginRoute;
        if (isLoggingIn) return isAuth ? Constants.dashboardRoute : null;

        return isAuth ? null : Constants.loginRoute;
      },
      debugLogDiagnostics: true,
      errorPageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: ErrorScreen(
            state: state,
            error: null,
          )
      )
  );
});
