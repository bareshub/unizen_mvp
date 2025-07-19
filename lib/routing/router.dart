import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:unizen/data/repositories/auth/auth_repository.dart';
import 'package:unizen/routing/routes.dart';
import 'package:unizen/ui/animated_scene/configs/scene_config.dart';
import 'package:unizen/ui/core/localization/applocalization.dart';
import 'package:unizen/ui/home_page/home_page.dart';
import 'package:unizen/domain/models/exam/exam.dart';
import 'package:unizen/ui/home_page/view_models/home_page_view_model.dart';

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
            sceneConfig: SceneConfig(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
          Exam(
            name: 'PHYSICS',
            maxHealth: 5000,
            health: 4878,
            sceneConfig: SceneConfig(
              modelAssetPath: 'build/models/toilet_after_blender.model',
            ),
          ),
          Exam(
            name: 'COMPUTER SCIENCE',
            maxHealth: 5000,
            health: 1280,
            sceneConfig: SceneConfig(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
          Exam(
            name: 'AUTOMATION',
            maxHealth: 5000,
            health: 2780,
            sceneConfig: SceneConfig(
              modelAssetPath: 'build/models/zombie_after_blender.model',
            ),
          ),
        ];

        return HomePage(viewModel: HomePageViewModel(exams: exams));
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
