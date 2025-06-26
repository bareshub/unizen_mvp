import 'package:flutter/material.dart';

import 'package:unizen/ui/core/ui/overlay_text.dart';
import 'package:unizen/ui/core/ui/unizen_logo.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/health_bar/health_bar.dart';
import 'package:unizen/ui/study_timer/study_timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _spaceBetweenAnimatedSceneAndHealthBar = 8.0;
  static const _spaceBetweenHealthBarAndStudyTimer = 24.0;
  static const _horizontalMarginHealthBar = 96.0;
  static const _horizontalMarginStudyTimer = 72.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final animatedSceneHeight =
                  constraints.maxHeight / 2 -
                  HealthBarSize.medium.height -
                  _spaceBetweenAnimatedSceneAndHealthBar -
                  _spaceBetweenHealthBarAndStudyTimer;

              return Column(
                children: [
                  UnizenLogo(),
                  _AnimatedSceneSection(height: animatedSceneHeight),
                  const SizedBox(
                    height: _spaceBetweenAnimatedSceneAndHealthBar,
                  ),
                  _HealthBarSection(
                    margin: const EdgeInsets.symmetric(
                      horizontal: _horizontalMarginHealthBar,
                    ),
                  ),
                  const SizedBox(height: _spaceBetweenHealthBarAndStudyTimer),
                  _StudyTimerSection(
                    margin: EdgeInsets.all(_horizontalMarginStudyTimer),
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

class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        OverlayText(
          'AUTOMATION', // TODO: get from Exam object
          margin: const EdgeInsets.symmetric(horizontal: 96.0, vertical: 8.0),
        ),
        SizedBox(
          height: height,
          width: double.infinity,
          child: AnimatedScene(
            viewModel: AnimatedSceneViewModel(
              // TODO: get from Exam object
              config: SceneConfig(
                modelAssetPath: 'build/models/zombie_after_blender.model',
                environmentIntensity: 3,
                cameraDistance: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HealthBarSection extends StatelessWidget {
  const _HealthBarSection({this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBar(
      viewModel: HealthBarViewModel(
        config: HealthBarConfig(size: HealthBarSize.medium),
        // TODO: get from Exam object
        maxHealth: 5000,
        // TODO: get from Exam object
        health: 1850,
      ),
      margin: margin,
    );
  }
}

class _StudyTimerSection extends StatelessWidget {
  const _StudyTimerSection({this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return StudyTimer(
      viewModel: StudyTimerViewModel(config: StudyTimerConfig()),
      examName: 'AUTOMATION',
      margin: margin,
    );
  }
}
