import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../ui/animated_scene/animated_scene.dart';
import '../../../ui/core/ui/liquid_glass_box.dart';
import '../../../ui/home_screen/home_screen.dart';
import '../../../ui/roadmap_screen/roadmap_screen.dart';
import '../../core/ui/liquid_glass_icon_button.dart';
import '../../home_screen/widgets/add_exam_modal.dart';
import 'boss_row_widget.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  static const avatarHeight = 72.0;
  static const avatarWidth = 40.0;
  static const horizontalMargin = 48.0;
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

  double get totalMaxHealth => widget.viewModel.exams.value.fold<double>(
    0,
    (acc, exam) => acc + exam.maxHealth,
  );
  double get totalHealth => widget.viewModel.exams.value.fold<double>(
    0,
    (acc, exam) => acc + exam.health,
  );
  double get progress => totalHealth / totalMaxHealth;

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
        valueListenable: widget.viewModel.state,
        builder: (context, state, child) {
          if ([
            RoadmapScreenState.initial,
            RoadmapScreenState.loading,
          ].contains(state)) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // TODO improve progress indicator
          }

          return ValueListenableBuilder(
            valueListenable: widget.viewModel.exams,
            builder: (context, exams, _) {
              // TODO if exams.empty
              if (exams.isEmpty) {
                return Placeholder(); // TODO replace with empty list handling
              }

              return Stack(
                children: [
                  ListView.builder(
                    controller: _examListController,
                    itemCount: exams.length,
                    itemBuilder: (_, index) => _buildBossRow(index - 2, exams),
                  ),
                  IgnorePointer(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).padding.top,
                      ),
                      controller: _roadmapScrollController,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: RoadmapProgressWidget(
                              bossesCount: exams.length - 2,
                              bossHeight: BossRowWidget.bossSectionHeight,
                              progress: progress,
                              viewModel: roadmapProgressViewModel,
                            ),
                          ),
                          AnimatedBuilder(
                            // TODO check if animation needed
                            animation: roadmapProgressViewModel,
                            builder: (context, _) {
                              final currentPoint =
                                  roadmapProgressViewModel.currentPoint;
                              if (currentPoint == null) return const SizedBox();

                              return Positioned(
                                // TODO refactor
                                top:
                                    currentPoint.dy -
                                    RoadmapScreenWidget.avatarHeight, // heigth
                                // TODO refactor
                                left:
                                    MediaQuery.of(context).size.width / 2 +
                                    currentPoint.dx -
                                    RoadmapScreenWidget.avatarWidth /
                                        2, // witdh / 2
                                child: SizedBox(
                                  height: RoadmapScreenWidget.avatarHeight,
                                  width: RoadmapScreenWidget.avatarWidth,
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
                  // TODO refactor
                  SafeArea(
                    child: Container(
                      height: BossRowWidget.bossSectionHeight,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 80.0),
                      child: LiquidGlassBox(
                        ambientStrength: 0.5,
                        chromaticAberration: 10,
                        lightIntensity: 0.95,
                        refractiveIndex: 1.51,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.school_outlined,
                                  //   color: Colors.blue.withAlpha(160),
                                  //   size: 20,
                                  // ),
                                  // SizedBox(width: 8.0),
                                  Text(
                                    'University: ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'DTU',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.flag_outlined,
                                  //   color: Colors.red.withAlpha(160),
                                  //   size: 20,
                                  // ),
                                  // SizedBox(width: 8.0),
                                  Text(
                                    'Exams Passed: ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  // TODO count exams with grade (or add passed derived property to Exam)
                                  Text(
                                    '0 ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  // TODO count exams
                                  Text(
                                    '/ 4',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.leaderboard_outlined,
                                  //   color: Colors.green.withAlpha(160),
                                  //   size: 20,
                                  // ),
                                  // SizedBox(width: 8.0),
                                  Text(
                                    'GPA: ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  // TODO sum exams grade and divide by exam with grade
                                  Text(
                                    '- ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    // ?.copyWith(color: Colors.white),
                                  ),
                                  // TODO same "config" or "profile" as the University
                                  Text(
                                    '/ 12',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ), // TODO replace with info box
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBossRow(int index, List<Exam> exams) {
    final alignRight =
        (exams.length.isOdd && index.isOdd) ||
        (exams.length.isEven && index.isEven);
    final alignment = alignRight ? Alignment.centerRight : Alignment.centerLeft;

    if (index == -2) {
      return SizedBox(height: BossRowWidget.bossSectionHeight);
    }

    if (index == -1) {
      return SizedBox(
        height: BossRowWidget.bossSectionHeight,
        child: Row(
          children: [
            if (exams.length.isOdd) Spacer(flex: 3),
            Expanded(flex: 2, child: Center(child: _buildAddExamButton())),
            if (exams.length.isEven) Spacer(flex: 3),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RoadmapScreenWidget.horizontalMargin,
      ),
      child: BossRowWidget(exam: exams[index], alignment: alignment),
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
}
