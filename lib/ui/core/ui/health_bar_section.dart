import 'package:flutter/material.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../health_bar/health_bar.dart';

class HealthBarSection extends StatelessWidget {
  const HealthBarSection({super.key, required this.exam, this.margin});

  final Exam exam;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBarWidget(
      viewModel: HealthBarViewModel(
        config: HealthBar(size: HealthBarSize.medium),
        maxHealth: exam.maxHealth,
        health: exam.health,
      ),
      margin: margin,
    );
  }
}
