import 'package:flutter/material.dart';
import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/core/ui/custom_painter_spike.dart';

import '../../../domain/models/animated_scene/animated_scene.dart';
import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../../ui/core/ui/liquid_glass_icon_button.dart';
import '../../core/ui/overlay_text.dart';
import '../../health_bar/view_models/health_bar_view_model.dart';
import '../../health_bar/widgets/health_bar_widget.dart';
import '../view_models/add_exam_page_view_model.dart';
import '../view_models/home_screen_view_model.dart';

class AddExamPageWidget extends StatelessWidget {
  const AddExamPageWidget({
    super.key,
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _AnimatedSceneSection(
                  height: 150,
                  exam: Exam(
                    name: 'AUTOMATION',
                    maxHealth: 5000,
                    health: 2780,
                    boss: Boss(
                      animatedScene: AnimatedScene(
                        modelAssetPath: 'build/models/tv_man_supreme.model',
                        cameraDistance: 16,
                      ),
                      ects: 6,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                _HealthBarSection(
                  exam: Exam(
                    name: 'AUTOMATION',
                    maxHealth: 5000,
                    health: 2780,
                    boss: Boss(
                      animatedScene: AnimatedScene(
                        modelAssetPath: 'build/models/tv_man_supreme.model',
                        cameraDistance: 16,
                      ),
                      ects: 6,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 48.0),
                ),
                SizedBox(height: 310),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: LiquidGlassIconButton(
                    icon: Icons.add_rounded,
                    size: 60.0,
                    onPressed: () => _onAddExamPressed(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CustomPaint(
              painter: CurvedZigZagPainter(curveCount: 3, curveHeight: 160),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 156),
                _AnimatedSceneSection(
                  height: 150,
                  exam: Exam(
                    name: 'MACHINE LEARNING',
                    maxHealth: 5000,
                    health: 2780,
                    boss: Boss(
                      animatedScene: AnimatedScene(
                        modelAssetPath: 'build/models/tvman_supreme.model',
                        cameraDistance: 44,
                      ),
                      ects: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                _HealthBarSection(
                  exam: Exam(
                    name: 'MACHINE LEARNING',
                    maxHealth: 4800,
                    health: 4027,
                    boss: Boss(
                      animatedScene: AnimatedScene(
                        modelAssetPath: 'build/models/tvman_supreme.model',
                        cameraDistance: 44,
                      ),
                      ects: 3,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 48.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onAddExamPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.primary,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 120.0,
          // child: AddExamModal(
          //   viewModel: viewModel,
          //   timelineScreenViewModel: homeScreenViewModel,
          // ),
        );
      },
    );
  }
}

class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({required this.exam, required this.height});

  final Exam exam;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        OverlayText(
          exam.name,
          margin: const EdgeInsets.symmetric(horizontal: 48.0),
        ),
        SizedBox(
          height: height,
          width: double.infinity,
          child: AnimatedSceneWidget(exam: exam),
        ),
      ],
    );
  }
}

class _HealthBarSection extends StatelessWidget {
  const _HealthBarSection({required this.exam, this.margin});

  final Exam exam;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBarWidget(
      viewModel: HealthBarViewModel(
        config: HealthBar(size: HealthBarSize.medium),
        maxHealth: exam.maxHealth,
        health: exam.health,
      ),
      margin: margin,
    );
  }
}
