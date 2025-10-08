import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/animated_scene/animated_scene.dart';
import '../../../ui/roadmap_screen/roadmap_screen.dart';
import '../../../ui/home_screen/view_models/add_exam_page_view_model.dart';
import '../../../ui/roadmap_screen/view_models/roadmap_progress_view_model.dart';
import '../view_models/roadmap_screen_view_model.dart';
import 'package:unizen/domain/models/exam/exam.dart';
import 'roadmap_boss_row.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  static const edgeMargin = 48.0;
  static const plusButtonSize = 72.0;

  final RoadmapScreenViewModel viewModel;

  @override
  State<RoadmapScreenWidget> createState() => _RoadmapScreenWidgetState();
}

class _RoadmapScreenWidgetState extends State<RoadmapScreenWidget> {
  final _examListController = ScrollController();
  final _roadmapScrollController = ScrollController();

  late final AddExamPageViewModel addExamPageViewModel;
  late final RoadmapProgressViewModel roadmapProgressViewModel;

  @override
  void initState() {
    super.initState();

    _syncScrollControllers();

    addExamPageViewModel = AddExamPageViewModel(bossRepository: context.read());
    roadmapProgressViewModel = RoadmapProgressViewModel();

    if (widget.viewModel.state.value == RoadmapScreenState.initial) {
      widget.viewModel.loadCommand.execute();
    }
  }

  void _syncScrollControllers() {
    _examListController.addListener(() {
      if (_roadmapScrollController.hasClients) {
        _roadmapScrollController.jumpTo(_examListController.offset);
      }
    });

    // to avoid debounch problems
    _roadmapScrollController.addListener(() {
      if (_roadmapScrollController.offset != _examListController.offset) {
        _roadmapScrollController.jumpTo(_examListController.offset);
      }
    });
  }

  @override
  void dispose() {
    _examListController.dispose();
    _roadmapScrollController.dispose();

    addExamPageViewModel.dispose();
    roadmapProgressViewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ValueListenableBuilder(
        valueListenable: widget.viewModel.exams,
        builder: (context, exams, _) {
          // TODO if exams.empty
          if (exams.isEmpty) return Placeholder();

          return Stack(
            children: [
              ListView.builder(
                controller: _examListController,
                itemCount: exams.length,
                itemBuilder: (_, index) => _buildBossRow(index, exams),
              ),
              IgnorePointer(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: RoadmapScreenWidget.edgeMargin),
                  controller: _roadmapScrollController,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: RoadmapProgressWidget(
                          bossesCount: exams.length,
                          bossHeight: BossRow.bossSectionHeight,
                          progress: 0.1, // TODO change
                          viewModel: roadmapProgressViewModel,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: roadmapProgressViewModel,
                        builder: (context, _) {
                          final currentPoint = roadmapProgressViewModel.currentPoint;
                          if (currentPoint == null) return const SizedBox();

                          return Positioned(
                            // TODO refactor
                            top: currentPoint.dy - 120, // heigth
                            // TODO refactor
                            left:
                                MediaQuery.of(context).size.width / 2 +
                                currentPoint.dx -
                                10, // witdh / 2
                            child: SizedBox(
                              height: 120, // TODO refactor
                              width: 20, // TODO refactor
                              child: AnimatedSceneWidget.avatar(
                                avatar: widget.viewModel.avatar.value,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBossRow(int index, List<Exam> exams) {
    final alignLeft = (exams.length.isOdd && index.isOdd) || (exams.length.isEven && index.isEven);
    final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        RoadmapScreenWidget.edgeMargin,
        index == 0 ? 2 * BossRow.bossSectionHeight : 0,
        RoadmapScreenWidget.edgeMargin,
        0,
      ),
      child: BossRow(exam: exams[index], alignment: alignment),
    );
  }
}
