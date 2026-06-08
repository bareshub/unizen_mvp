import 'package:flutter/material.dart';

import '../../../domain/models/health_bar/health_bar.dart';
import '../../../domain/models/study_timer/study_timer.dart';
import '../../../ui/core/themes/theme.dart';
import '../../../ui/core/ui/animated_boss_section.dart';
import '../../core/ui/frosted_glass_text_button.dart';
import '../../core/ui/vertical_text.dart';
import '../../health_bar/health_bar.dart';
import '../../study_timer/study_timer.dart';
import '../view_models/exam_page_view_model.dart';

class ExamPageWidget extends StatefulWidget {
  const ExamPageWidget({super.key, required this.viewModel});

  final ExamPageViewModel viewModel;

  @override
  State<ExamPageWidget> createState() => _ExamPageWidgetState();
}

class _ExamPageWidgetState extends State<ExamPageWidget> {
  late final StudyTimerViewModel _studyTimerViewModel;
  late final HealthBarViewModel _healthBarViewModel;
  late final VoidCallback _minutesListener;

  @override
  void initState() {
    super.initState();

    _studyTimerViewModel = StudyTimerViewModel(config: StudyTimer());
    _healthBarViewModel = HealthBarViewModel(
      config: HealthBar(size: HealthBarSize.medium),
      maxHealth: widget.viewModel.model.exam.maxHealth,
      health: widget.viewModel.model.exam.health,
    );

    _minutesListener = _onStudyMinutesChanged;
    _studyTimerViewModel.minutes.addListener(_minutesListener);
  }

  @override
  void dispose() {
    _studyTimerViewModel.minutes.removeListener(_minutesListener);
    _studyTimerViewModel.dispose();
    _healthBarViewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            if (widget.viewModel.hasLeftVerticalText)
              VerticalText(
                text: widget.viewModel.model.lVerticalText!,
                alignment: Alignment.centerLeft,
              ),
            SingleChildScrollView(
              child: ValueListenableBuilder(
                valueListenable: _studyTimerViewModel.state,
                builder: (context, state, child) {
                  final animatedSceneHeight = widget.viewModel
                      .calculateAnimatedSceneHeight(
                        constraints.maxHeight,
                        state,
                      );

                  if (state == StudyTimerState.studying ||
                      state == StudyTimerState.paused) {
                    _healthBarViewModel.config.size = HealthBarSize.large;
                  }

                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: Durations.medium1,
                        height: animatedSceneHeight,
                        child: AnimatedBossSection(
                          exam: widget.viewModel.model.exam,
                          height: animatedSceneHeight,
                          overlayMargin: EdgeInsets.symmetric(
                            horizontal:
                                // (state == StudyTimerState.studying ? 0.5 : 1) *
                                ExamPageViewModel.horizontalMarginHealthBar,
                            vertical: 8.0, // TODO extract in a variable
                          ),
                        ),
                      ),
                      const SizedBox(
                        height:
                            ExamPageViewModel
                                .spaceBetweenAnimatedSceneAndHealthBar,
                      ),
                      HealthBarWidget(
                        viewModel: _healthBarViewModel,
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              // (state == StudyTimerState.studying ? 0.5 : 1) *
                              ExamPageViewModel.horizontalMarginHealthBar,
                        ),
                      ),
                      const SizedBox(
                        height:
                            ExamPageViewModel
                                .spaceBetweenHealthBarAndStudyTimer,
                      ),
                      switch (state) {
                        StudyTimerState.finished => Text(
                          'FINISHED',
                        ), // TODO change finished
                        StudyTimerState.studying ||
                        StudyTimerState.paused => ValueListenableBuilder(
                          valueListenable: _studyTimerViewModel.seconds,
                          builder:
                              (context, value, child) => Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _studyTimerViewModel.formattedMinutes,
                                      maxLines: 1,
                                      textAlign: TextAlign.end,
                                      style: AppTheme.timerLargeStyle,
                                    ),
                                  ),
                                  Text(
                                    ":",
                                    maxLines: 1,
                                    style: AppTheme.timerLargeStyle,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _studyTimerViewModel.formattedSeconds,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: AppTheme.timerLargeStyle,
                                    ),
                                  ),
                                ],
                              ),
                        ),
                        _ => StudyTimerWidget(
                          viewModel: _studyTimerViewModel,
                          examName: widget.viewModel.model.exam.name,
                          margin: EdgeInsets.all(
                            ExamPageViewModel.horizontalMarginStudyTimer,
                          ),
                          onStudyTimerStart: _onStudyTimerStart,
                          onStudyTimerEdit: _onStudyTimerEdit,
                        ),
                      },
                      SizedBox(height: 40.0),
                      if (state == StudyTimerState.studying ||
                          state == StudyTimerState.paused)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal:
                                ExamPageViewModel.horizontalMarginHealthBar *
                                1.5,
                          ),
                          child: Column(
                            spacing: 8.0,
                            children: [
                              FrostedGlassTextButton(
                                text:
                                    state == StudyTimerState.paused
                                        ? 'Start'
                                        : 'Pause',
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                foregroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                icon:
                                    state == StudyTimerState.paused
                                        ? Icons.play_arrow_rounded
                                        : Icons.pause_rounded,
                                action: _onStudyTimerPause,
                              ),
                              FrostedGlassTextButton(
                                text: 'Stop',
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.error.withAlpha(128),
                                icon: Icons.stop_rounded,
                                action: _onStudyTimerStop,
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            if (widget.viewModel.hasRightVerticalText)
              VerticalText(
                text: widget.viewModel.model.rVerticalText!,
                alignment: Alignment.centerRight,
              ),
          ],
        );
      },
    );
  }

  void _onStudyMinutesChanged() {
    if ([
      StudyTimerState.studying,
      StudyTimerState.paused,
      StudyTimerState.finished,
    ].contains(_studyTimerViewModel.state.value)) {
      _healthBarViewModel.decreaseHealthComamand.run();
    }
  }

  void _onStudyTimerStart() => _studyTimerViewModel.startTimerCommand.run();

  void _onStudyTimerEdit() {
    // TODO implement
  }

  void _onStudyTimerPause() =>
      _studyTimerViewModel.togglePauseTimerCommand.run();

  void _onStudyTimerStop() => _studyTimerViewModel.stopTimerCommand.run();
}
