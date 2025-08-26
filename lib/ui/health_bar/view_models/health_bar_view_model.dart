import 'dart:async' show Timer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../domain/models/health_bar/health_bar.dart';

class HealthBarViewModel extends ChangeNotifier {
  HealthBarViewModel({
    required this.config,
    required maxHealth,
    required health,
  }) {
    this.maxHealth = ValueNotifier(maxHealth);
    this.health = ValueNotifier(health);

    startTimerCommand = Command.createSyncNoParamNoResult(_startTimer);
    stopTimerCommand = Command.createSyncNoParamNoResult(_stopTimer);
  }

  final HealthBar config;

  // TODO move to Timer Widget, replace with "decreaseHealthComamand"
  late final Command<void, void> startTimerCommand;
  late final Command<void, void> stopTimerCommand;

  late final ValueNotifier<int> maxHealth;
  late final ValueNotifier<int> health;

  Timer? _timer;

  void _startTimer() {
    Timer.periodic(Duration(minutes: 1), (_) {
      health.value = max(health.value - 1, 0);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    maxHealth.dispose();
    health.dispose();
    super.dispose();
  }
}
