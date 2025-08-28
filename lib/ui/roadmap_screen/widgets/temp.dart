import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:unizen/ui/home_screen/view_models/add_exam_page_view_model.dart';
import 'package:unizen/ui/roadmap_screen/view_models/roadmap_progress_view_model.dart';
import '../../../domain/models/health_bar/health_bar.dart';
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
    throw UnimplementedError();
  }
}
