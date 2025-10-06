import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../../ui/core/ui/animated_boss_section.dart';
import '../../../ui/core/ui/health_bar_section.dart';
import '../../../ui/home_screen/view_models/add_exam_page_view_model.dart';
import '../../../ui/roadmap_screen/view_models/roadmap_progress_view_model.dart';
import '../view_models/roadmap_screen_view_model.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  static const bossHeight = 120.0;
  static const healthBarSize = HealthBarSize.medium;
  static const horizontalMargin = 48.0;
  static const spaceAboveBoss = 12.0;
  static const spaceBetweenBossAndHealthBar = 8.0;
  static const spaceBelowHealthBar = 24.0;
  static const plusButtonSize = 72.0;

  static double get bossSectionHeight =>
      RoadmapScreenWidget.bossHeight +
      RoadmapScreenWidget.spaceAboveBoss +
      RoadmapScreenWidget.spaceBetweenBossAndHealthBar +
      RoadmapScreenWidget.healthBarSize.height +
      RoadmapScreenWidget.spaceBelowHealthBar;

  final RoadmapScreenViewModel viewModel;

  @override
  State<RoadmapScreenWidget> createState() => _RoadmapScreenWidgetState();
}

class _RoadmapScreenWidgetState extends State<RoadmapScreenWidget> {
  late final AddExamPageViewModel addExamPageViewModel;
  late final RoadmapProgressViewModel roadmapProgressViewModel;

  @override
  void initState() {
    super.initState();

    addExamPageViewModel = AddExamPageViewModel(bossRepository: context.read());
    roadmapProgressViewModel = RoadmapProgressViewModel();

    if (widget.viewModel.state.value == RoadmapScreenState.initial) {
      widget.viewModel.loadCommand.execute();
    }
  }

  @override
  void dispose() {
    addExamPageViewModel.dispose();
    roadmapProgressViewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: widget.viewModel.exams,
          builder: (context, exams, _) {
            // TODO if exams.empty
            return ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final alignLeft =
                    (exams.length.isOdd && index.isOdd) ||
                    (exams.length.isEven && index.isEven);
                final alignment =
                    alignLeft ? Alignment.centerLeft : Alignment.centerRight;
                return BossRow(exam: exams[index], alignment: alignment);
              },
            );
          },
        ),
      ),
    );
  }
}

class BossRow extends StatelessWidget {
  const BossRow({super.key, required this.exam, required this.alignment});

  static const leftAlignments = <AlignmentGeometry>[
    Alignment.topLeft,
    AlignmentGeometry.centerLeft,
    Alignment.bottomLeft,
  ];

  final Exam exam;
  final AlignmentGeometry alignment;
  TextAlign get textAlign =>
      leftAlignments.contains(alignment) ? TextAlign.left : TextAlign.right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (textAlign == TextAlign.left) _buildBossInfo(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: RoadmapScreenWidget.spaceAboveBoss),
              AnimatedBossSection(
                exam: exam,
                height: RoadmapScreenWidget.bossHeight,
                showOverlay: false,
              ),
              const SizedBox(
                height: RoadmapScreenWidget.spaceBetweenBossAndHealthBar,
              ),
              HealthBarSection(exam: exam),
              const SizedBox(height: RoadmapScreenWidget.spaceBelowHealthBar),
            ],
          ),
        ),
        if (textAlign == TextAlign.right) _buildBossInfo(),
      ],
    );
  }

  Widget _buildBossInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        height: RoadmapScreenWidget.bossSectionHeight,
        alignment: alignment,
        child: Text(
          exam.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
