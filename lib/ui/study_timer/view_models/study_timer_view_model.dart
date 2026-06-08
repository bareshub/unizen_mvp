import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:command_it/command_it.dart';

import '../../../domain/models/study_timer/study_timer.dart';

enum StudyTimerState { initial, studying, paused, stopped, finished }

class StudyTimerViewModel extends ChangeNotifier {
  StudyTimerViewModel({required this.config})
    : _currentStepMinutesIndex = config.defaultStepMinutesIndex {
    minutes = ValueNotifier(config.defaultMinutes);
    seconds = ValueNotifier(0);
    state = ValueNotifier(StudyTimerState.initial);

    incrementTimerCommand = Command.createSyncNoParamNoResult(_incrementTimer);
    decrementTimerCommand = Command.createSyncNoParamNoResult(_decrementTimer);
    setMinutesCommand = Command.createSyncNoResult<int>(_setMinutes);
    startTimerCommand = Command.createSyncNoParamNoResult(_startTimer);
    togglePauseTimerCommand = Command.createSyncNoParamNoResult(
      _togglePauseTimer,
    );
    stopTimerCommand = Command.createSyncNoParamNoResult(_stopTimer);
  }

  Timer? _timer;
  int _currentStepMinutesIndex;

  final StudyTimer config;

  late final ValueNotifier<int> minutes;
  late final ValueNotifier<int> seconds;
  late final ValueNotifier<StudyTimerState> state;

  late final Command<void, void> incrementTimerCommand;
  late final Command<void, void> decrementTimerCommand;
  late final Command<int, void> setMinutesCommand;
  late final Command<void, void> startTimerCommand;
  late final Command<void, void> togglePauseTimerCommand;
  late final Command<void, void> stopTimerCommand;

  bool get incrementable =>
      _currentStepMinutesIndex < config.stepMinutes.length - 1;

  bool get decrementable => _currentStepMinutesIndex > 0;

  String get formattedMinutes =>
      "${minutes.value < 10 ? '0' : ''}${minutes.value}";
  String get formattedSeconds =>
      "${seconds.value < 10 ? '0' : ''}${seconds.value}";

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

  void _startTimer() {
    // TODO replace based on system time, save it locally and compare to current time once a second
    state.value = StudyTimerState.studying;
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      seconds.value = seconds.value - 1;
      if (seconds.value < 0) {
        seconds.value = 59;
        minutes.value = max(minutes.value - 1, 0);
      }
      if (seconds.value == 0 && minutes.value == 0) {
        state.value = StudyTimerState.finished;
      }
      notifyListeners();
    });
  }

  void _togglePauseTimer() {
    _timer?.cancel();
    if (state.value == StudyTimerState.paused) {
      _startTimer();
    } else {
      state.value = StudyTimerState.paused;
    }
    notifyListeners();
  }

  void _stopTimer() {
    _timer?.cancel();
    state.value = StudyTimerState.stopped;
    minutes.value = config.stepMinutes[_currentStepMinutesIndex];
    seconds.value = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    minutes.dispose();
    seconds.dispose();
    state.dispose();
    super.dispose();
  }
}
