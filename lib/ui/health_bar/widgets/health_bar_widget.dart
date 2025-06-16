import 'package:flutter/material.dart';

import './health_bar_background.dart';
import './health_bar_content.dart';
import './health_bar_fill.dart';
import '../view_models/health_bar_view_model.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({super.key, required this.viewModel, this.margin});

  final HealthBarViewModel viewModel;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBarBackground(
      margin: margin,
      height: viewModel.config.size.height,
      child: ValueListenableBuilder(
        valueListenable: viewModel.health,
        builder: (context, health, _) {
          final maxHealth = viewModel.maxHealth.value;

          return HealthBarFill(
            health: health,
            maxHealth: maxHealth,
            child: HealthBarContent(health: health),
          );
        },
      ),
    );
  }
}
