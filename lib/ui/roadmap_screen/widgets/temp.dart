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

  final bossHeight = 120.0;
  final healthBarSize = HealthBarSize.medium;
  final horizontalMargin = 48.0;
  final spaceAboveBoss = 12.0;
  final spaceBetweenBossAndHealthBar = 8.0;
  final spaceBelowHealthBar = 24.0;
  final plusButtonSize = 72.0;

  final RoadmapScreenViewModel viewModel;

  @override
  State<RoadmapScreenWidget> createState() => _RoadmapScreenWidgetState();
}

class _RoadmapScreenWidgetState extends State<RoadmapScreenWidget> {
  late final AddExamPageViewModel addExamPageViewModel;
  late final RoadmapProgressViewModel roadmapProgressViewModel;

  double get bossSectionHeight =>
      widget.bossHeight +
      widget.spaceAboveBoss +
      widget.spaceBetweenBossAndHealthBar +
      widget.healthBarSize.height +
      widget.spaceBelowHealthBar;

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
                return _buildBossRow(exam: exams[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBossRow({
    required Exam exam,
    AlignmentGeometry alignment = AlignmentGeometry.centerLeft,
  }) {
    var textAlign =
        alignment == AlignmentGeometry.centerLeft
            ? TextAlign.left
            : TextAlign.right;
    final bossInfo = Expanded(
      flex: 3,
      child: Container(
        height: bossSectionHeight,
        alignment: alignment,
        child: Text(
          exam.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
        ),
      ),
    );

    return Row(
      children: [
        bossInfo,
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: widget.spaceAboveBoss),
              AnimatedBossSection(
                exam: exam,
                height: widget.bossHeight,
                showOverlay: false,
              ),
              SizedBox(height: widget.spaceBetweenBossAndHealthBar),
              HealthBarSection(exam: exam),
              SizedBox(height: widget.spaceBelowHealthBar),
            ],
          ),
        ),
      ],
    );
  }
}
