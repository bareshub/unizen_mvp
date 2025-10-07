import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/home_screen/view_models/add_exam_page_view_model.dart';
import '../../../ui/roadmap_screen/view_models/roadmap_progress_view_model.dart';
import '../view_models/roadmap_screen_view_model.dart';
import 'roadmap_boss_row.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  // static const horizontalMargin = 48.0;
  static const plusButtonSize = 72.0;

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
                    (exams.length.isOdd && index.isOdd) || (exams.length.isEven && index.isEven);
                final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;
                return BossRow(exam: exams[index], alignment: alignment);
              },
            );
          },
        ),
      ),
    );
  }
}
