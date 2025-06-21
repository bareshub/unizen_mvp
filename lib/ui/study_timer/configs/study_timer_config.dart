class StudyTimerConfig {
  final List<int> stepMinutes;
  final int defaultStepMinutesIndex;

  const StudyTimerConfig({
    this.stepMinutes = const [15, 20, 25, 30, 45, 60, 90, 120],
    this.defaultStepMinutesIndex = 2,
  }) : assert(stepMinutes.length > 0),
       assert(
         defaultStepMinutesIndex >= 0 &&
             defaultStepMinutesIndex < stepMinutes.length,
       );

  int get defaultMinutes => stepMinutes[defaultStepMinutesIndex];
}
