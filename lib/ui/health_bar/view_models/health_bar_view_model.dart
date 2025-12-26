import 'dart:math' show max;

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

    decreaseHealthComamand = Command.createSyncNoParamNoResult(_decreaseHealth);
  }

  final HealthBar config;

  late final ValueNotifier<int> maxHealth;
  late final ValueNotifier<int> health;

  late final Command<void, void> decreaseHealthComamand;

  void _decreaseHealth() {
    health.value = max(health.value - 1, 0);
    notifyListeners();
  }

  @override
  void dispose() {
    maxHealth.dispose();
    health.dispose();
    super.dispose();
  }
}
