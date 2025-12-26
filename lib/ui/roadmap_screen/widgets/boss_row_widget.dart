import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../../routing/routes.dart';
import '../../../ui/core/ui/custom_ink_well.dart';
import '../../../ui/core/ui/overlay_text.dart';
import '../../core/ui/animated_boss_section.dart';
import '../../core/ui/health_bar_section.dart';

class BossRowWidget extends StatelessWidget {
  const BossRowWidget({super.key, required this.exam, required this.alignment});

  static const leftAlignments = <AlignmentGeometry>[
    Alignment.topLeft,
    AlignmentGeometry.centerLeft,
    Alignment.bottomLeft,
  ];

  static const spaceAboveBoss = 12.0;
  static const spaceBetweenBossAndHealthBar = 8.0;
  static const spaceBetweenBossAndExamName = 8.0;
  static const spaceBetweenRoadmapAndExamName = 32.0;
  static const spaceBelowHealthBar = 24.0;
  static const bossHeight = 120.0;
  static const healthBarSize = HealthBarSize.medium;

  static double get bossSectionHeight =>
      BossRowWidget.bossHeight +
      BossRowWidget.spaceAboveBoss +
      BossRowWidget.spaceBetweenBossAndHealthBar +
      BossRowWidget.healthBarSize.height +
      BossRowWidget.spaceBelowHealthBar;

  final Exam exam;
  final AlignmentGeometry alignment;

  bool get isLeftAliged => leftAlignments.contains(alignment);
  TextAlign get textAlign => isLeftAliged ? TextAlign.left : TextAlign.right;
  EdgeInsetsGeometry get examInfoMargin => EdgeInsets.only(
    left:
        isLeftAliged
            ? spaceBetweenRoadmapAndExamName
            : spaceBetweenBossAndExamName,
    right:
        isLeftAliged
            ? spaceBetweenBossAndExamName
            : spaceBetweenRoadmapAndExamName,
  );

  @override
  Widget build(BuildContext context) {
    final examInfoWidget = Expanded(
      flex: 3,
      child: OverlayText(
        exam.name,
        alignment: alignment,
        fontSize: 36.0,
        maxHeight: bossSectionHeight,
        maxLines: 2,
        margin: examInfoMargin,
        opacity: 0.70,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );

    return Row(
      children: [
        if (textAlign == TextAlign.right) examInfoWidget,
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: spaceAboveBoss),
              CustomInkWell(
                onTap: () => _onBossTap(context),
                child: AnimatedBossSection(
                  exam: exam,
                  height: bossHeight,
                  showOverlay: false,
                ),
              ),
              const SizedBox(height: spaceBetweenBossAndHealthBar),
              HealthBarSection(exam: exam),
              const SizedBox(height: spaceBelowHealthBar),
            ],
          ),
        ),
        if (textAlign == TextAlign.left) examInfoWidget,
      ],
    );
  }

  void _onBossTap(BuildContext context) =>
      context.push(Routes.exam, extra: exam);
}
