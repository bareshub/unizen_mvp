import 'package:flutter/material.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../core/ui/animated_boss_section.dart';
import '../../core/ui/health_bar_section.dart';

class BossRow extends StatelessWidget {
  const BossRow({super.key, required this.exam, required this.alignment});

  static const leftAlignments = <AlignmentGeometry>[
    Alignment.topLeft,
    AlignmentGeometry.centerLeft,
    Alignment.bottomLeft,
  ];

  static const spaceAboveBoss = 12.0;
  static const spaceBetweenBossAndHealthBar = 8.0;
  static const spaceBelowHealthBar = 24.0;
  static const bossHeight = 120.0;
  static const healthBarSize = HealthBarSize.medium;

  static double get bossSectionHeight =>
      BossRow.bossHeight +
      BossRow.spaceAboveBoss +
      BossRow.spaceBetweenBossAndHealthBar +
      BossRow.healthBarSize.height +
      BossRow.spaceBelowHealthBar;

  final Exam exam;
  final AlignmentGeometry alignment;

  TextAlign get textAlign => leftAlignments.contains(alignment) ? TextAlign.left : TextAlign.right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (textAlign == TextAlign.left) _buildBossInfo(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: spaceAboveBoss),
              AnimatedBossSection(exam: exam, height: bossHeight, showOverlay: false),
              const SizedBox(height: spaceBetweenBossAndHealthBar),
              HealthBarSection(exam: exam),
              const SizedBox(height: spaceBelowHealthBar),
            ],
          ),
        ),
        if (textAlign == TextAlign.right) _buildBossInfo(),
      ],
    );
  }

  Widget _buildBossInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        height: bossSectionHeight,
        alignment: alignment,
        child: Text(exam.name, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: textAlign),
      ),
    );
  }
}
