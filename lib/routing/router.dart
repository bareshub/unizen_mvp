import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../ui/core/localization/applocalization.dart';
import '../ui/home_screen/home_screen.dart';
import '../ui/home_screen/view_models/home_screen_view_model.dart';
import '../ui/splash/splash_screen.dart';
import 'routes.dart';

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user to /logout.
GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.splash,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(AppLocalization.of(context).title)),
        ); // TODO replace with LoginScreen
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return HomeScreenWidget(
          viewModel: HomeScreenViewModel(examRepository: context.read()),
        );
      },
      routes: [],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, he needs to login
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;

  if (!loggedIn) {
    return Routes.login;
  }

  // if the user is logged but still on login page, send him to the home page
  if (loggingIn) {
    return Routes.home;
  }

  // no need to redirect
  return null;
}
