import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unizen/domain/models/health_bar/health_bar.dart';
import 'package:unizen/ui/core/ui/custom_painter_spike.dart';
import 'package:unizen/ui/core/ui/liquid_glass_icon_button.dart';
import 'package:unizen/ui/core/ui/unizen_logo.dart';

import '../../../domain/models/exam/exam.dart';
import '../../animated_scene/widgets/animated_scene_widget.dart';
import '../../core/ui/overlay_text.dart';
import '../../health_bar/view_models/health_bar_view_model.dart';
import '../../health_bar/widgets/health_bar_widget.dart';
import '../../home_screen/view_models/add_exam_page_view_model.dart';
import '../../home_screen/widgets/add_exam_modal.dart';
import '../view_models/roadmap_screen_view_model.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  static const horizontalMargin = 48.0;
  static const bossHeight = 150.0;
  static const spaceBetweenAnimatedSceneAndHealthBar = 8.0;
  static const HealthBarSize healthBarSize = HealthBarSize.medium;
  static const plusButtonSize = 60.0;

  final RoadmapScreenViewModel viewModel;

  @override
  State<RoadmapScreenWidget> createState() => _RoadmapScreenWidgetState();
}

class _RoadmapScreenWidgetState extends State<RoadmapScreenWidget> {
  late final AddExamPageViewModel addExamPageViewModel;

  double get bossHeight =>
      RoadmapScreenWidget.bossHeight +
      RoadmapScreenWidget.spaceBetweenAnimatedSceneAndHealthBar +
      RoadmapScreenWidget.healthBarSize.height;

  @override
  void initState() {
    super.initState();

    widget.viewModel.loadCommand.executeWithFuture();
  }

  @override
  Widget build(BuildContext context) {
    addExamPageViewModel = AddExamPageViewModel(bossRepository: context.read());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(title: UnizenLogo(), toolbarHeight: 24),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: widget.viewModel.state,
              builder: (context, state, child) {
                // TODO implement return values based on state
                return switch (state) {
                  RoadmapScreenState.initial => Center(
                    child: CircularProgressIndicator(),
                  ),
                  RoadmapScreenState.loading => Center(
                    child: CircularProgressIndicator(),
                  ),
                  RoadmapScreenState.error => Center(
                    child: CircularProgressIndicator(),
                  ),
                  _ => child!,
                };
              },
              child: ValueListenableBuilder(
                valueListenable: widget.viewModel.exams,
                builder: (context, exams, _) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            ...exams.asMap().entries.map<Widget>((entry) {
                              final first = entry.key == 0;
                              final even = exams.length.isEven;
                              final addExamButton =
                                  first
                                      ? Align(
                                        alignment: AlignmentGeometry.topRight,
                                        child: _buildAddExamButton(),
                                      )
                                      : null;

                              return switch ((even && entry.key.isEven) ||
                                  (!even && entry.key.isOdd)) {
                                true => _buildBoss(entry.value, first),
                                false => _buildBossEmptyPlaceholder(
                                  button: addExamButton,
                                ),
                              };
                            }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: CustomPaint(
                          size: Size(0, bossHeight * (exams.length + 1)),
                          painter: CurvedZigZagPainter(
                            curveCount: exams.length + 1,
                            curveHeight: bossHeight,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            ...exams.asMap().entries.map<Widget>((entry) {
                              final first = entry.key == 0;
                              final odd = exams.length.isOdd;
                              final addExamButton =
                                  first
                                      ? Align(
                                        alignment: AlignmentGeometry.topLeft,
                                        child: _buildAddExamButton(),
                                      )
                                      : null;

                              return switch ((!odd && entry.key.isOdd) ||
                                  (odd && entry.key.isEven)) {
                                true => _buildBoss(entry.value, first),
                                false => _buildBossEmptyPlaceholder(
                                  button: addExamButton,
                                ),
                              };
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddExamButton() => LiquidGlassIconButton(
    icon: Icons.add_rounded,
    size: RoadmapScreenWidget.plusButtonSize,
    onPressed:
        () => showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.primary,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 120.0,
              child: AddExamModal(
                viewModel: addExamPageViewModel,
                timelineScreenViewModel: widget.viewModel,
              ),
            );
          },
        ), // TODO
  );

  Widget _buildBoss(Exam exam, bool first) {
    return Column(
      key: ValueKey(exam.id),
      children: [
        if (first) _buildBossEmptyPlaceholder(),
        _AnimatedSceneSection(
          exam: exam,
          height: RoadmapScreenWidget.bossHeight,
          margin: const EdgeInsets.symmetric(
            horizontal: RoadmapScreenWidget.horizontalMargin,
          ),
        ),
        const SizedBox(
          height: RoadmapScreenWidget.spaceBetweenAnimatedSceneAndHealthBar,
        ),
        _HealthBarSection(
          exam: exam,
          margin: EdgeInsets.symmetric(
            horizontal: RoadmapScreenWidget.horizontalMargin,
          ),
        ),
      ],
    );
  }

  Widget _buildBossEmptyPlaceholder({Widget? button}) {
    return Column(
      children: [
        if (button != null) SizedBox(height: bossHeight, child: button),
        SizedBox(height: bossHeight),
      ],
    );
  }
}

// TODO extract
class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({
    required this.exam,
    required this.height,
    this.margin,
  });

  final Exam exam;
  final double height;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        OverlayText(exam.name, margin: margin),
        SizedBox(
          height: height,
          width: double.infinity,
          child: AnimatedSceneWidget(exam: exam),
        ),
      ],
    );
  }
}

// TODO extract
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
