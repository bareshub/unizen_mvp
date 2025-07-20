import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../domain/models/exam/exam.dart';
import '../domain/models/animated_scene/animated_scene.dart';
import '../ui/core/localization/applocalization.dart';
import '../ui/home_page/home_page.dart';
import '../ui/home_page/view_models/home_page_view_model.dart';
import 'routes.dart';

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user to /logout.
GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
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
        // TODO get from repository
        List<Exam> exams = [
          Exam(
            name: 'AUTOMATION',
            maxHealth: 5000,
            health: 2780,
            animatedScene: AnimatedScene(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
          Exam(
            name: 'PHYSICS',
            maxHealth: 5000,
            health: 4878,
            animatedScene: AnimatedScene(
              modelAssetPath: 'build/models/toilet_after_blender.model',
            ),
          ),
          Exam(
            name: 'COMPUTER SCIENCE',
            maxHealth: 5000,
            health: 1280,
            animatedScene: AnimatedScene(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
          Exam(
            name: 'AUTOMATION',
            maxHealth: 5000,
            health: 2780,
            animatedScene: AnimatedScene(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
        ];

        return HomePageWidget(viewModel: HomePageViewModel(exams: exams));
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
