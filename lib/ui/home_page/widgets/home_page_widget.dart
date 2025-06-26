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
              const spaceBetweenAnimatedSceneAndHealthBar = 8.0;
              const spaceBetweenHealthBarAndStudyTimer = 24.0;

              const horizontalMarginHealthBar = 96.0;
              const horizontalMarginStudyTimer = 72.0;

              final animatedSceneHeight =
                  constraints.maxHeight / 2 -
                  HealthBarSize.medium.height -
                  spaceBetweenAnimatedSceneAndHealthBar -
                  spaceBetweenHealthBarAndStudyTimer;

              return Column(
                children: [
                  UnizenLogo(),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      OverlayText(
                        'AUTOMATION',
                        margin: const EdgeInsets.symmetric(
                          horizontal: 96.0,
                          vertical: 8.0,
                        ),
                      ),
                      SizedBox(
                        height: animatedSceneHeight,
                        width: double.infinity,
                        child: AnimatedScene(
                          viewModel: AnimatedSceneViewModel(
                            config: SceneConfig(
                              modelAssetPath:
                                  'build/models/zombie_after_blender.model',
                              environmentIntensity: 3,
                              cameraDistance: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spaceBetweenAnimatedSceneAndHealthBar),
                  HealthBar(
                    viewModel: HealthBarViewModel(
                      config: HealthBarConfig(size: HealthBarSize.medium),
                      maxHealth: 5000,
                      health: 1850,
                    ), //..startTimerCommand.execute(),
                    margin: const EdgeInsets.symmetric(
                      horizontal: horizontalMarginHealthBar,
                    ),
                  ),
                  const SizedBox(height: spaceBetweenHealthBarAndStudyTimer),
                  StudyTimer(
                    viewModel: StudyTimerViewModel(config: StudyTimerConfig()),
                    examName: 'AUTOMATION',
                    margin: EdgeInsets.all(horizontalMarginStudyTimer),
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
