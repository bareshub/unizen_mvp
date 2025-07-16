import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:unizen/ui/study_timer/configs/study_timer_config.dart';

class StudyTimerViewModel extends ChangeNotifier {
  final StudyTimerConfig config;

  late final ValueNotifier<int> minutes;
  late final Command<void, void> incrementTimerCommand;
  late final Command<void, void> decrementTimerCommand;
  late final Command<int, void> setMinutesCommand;

  int _currentStepMinutesIndex;

  bool get incrementable =>
      _currentStepMinutesIndex < config.stepMinutes.length - 1;

  bool get decrementable => _currentStepMinutesIndex > 0;

  StudyTimerViewModel({required this.config})
    : _currentStepMinutesIndex = config.defaultStepMinutesIndex {
    minutes = ValueNotifier(config.defaultMinutes);

    incrementTimerCommand = Command.createSyncNoParamNoResult(_incrementTimer);
    decrementTimerCommand = Command.createSyncNoParamNoResult(_decrementTimer);
    setMinutesCommand = Command.createSyncNoResult<int>(_setMinutes);
  }

  void _incrementTimer() {
    if (incrementable) {
      _currentStepMinutesIndex++;
      _updateMinutes();
    }
  }

  void _decrementTimer() {
    if (decrementable) {
      _currentStepMinutesIndex--;
      _updateMinutes();
    }
  }

  void _setMinutes(int newMinutes) {
    final index = config.stepMinutes.indexOf(newMinutes);
    if (index != -1 && index != _currentStepMinutesIndex) {
      _currentStepMinutesIndex = index;
      _updateMinutes();
    }
  }

  void _updateMinutes() {
    final value = config.stepMinutes[_currentStepMinutesIndex];
    minutes.value = value;
    notifyListeners();
  }

  @override
  void dispose() {
    minutes.dispose();
    super.dispose();
  }
}
