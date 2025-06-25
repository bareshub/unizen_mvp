import 'package:flutter/material.dart';

import 'package:unizen/ui/core/ui/overlay_text.dart';
import 'package:unizen/ui/core/ui/unizen_logo.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/health_bar/health_bar.dart';
import 'package:unizen/ui/study_timer/study_timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Positioned.fill(
                  //   top: constraints.maxHeight / 2,
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 1.0,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(child: UnizenLogo()),
                  ),
                  Positioned.fill(
                    bottom: 340,
                    child: Column(
                      children: [
                        Spacer(),
                        OverlayText(
                          'AUTOMATION',
                          margin: EdgeInsets.symmetric(horizontal: 100),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    // child: Container(),
                    child: AnimatedScene(
                      viewModel: AnimatedSceneViewModel(
                        config: SceneConfig(
                          modelAssetPath:
                              'build/models/zombie_after_blender.model',
                          environmentIntensity: 3,
                          cameraDistance: 11.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom:
                        constraints.maxHeight / 2 + HealthBarSize.medium.height,
                    child: Column(
                      children: [
                        HealthBar(
                          viewModel: HealthBarViewModel(
                            config: HealthBarConfig(size: HealthBarSize.medium),
                            maxHealth: 5000,
                            health: 1850,
                          ), //..startTimerCommand.execute(),
                          margin: const EdgeInsets.symmetric(horizontal: 100),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.topCenter,
                          child: StudyTimer(
                            viewModel: StudyTimerViewModel(
                              config: StudyTimerConfig(),
                            ),
                            examName: 'AUTOMATION',
                            margin: EdgeInsets.all(72.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
