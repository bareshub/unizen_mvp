import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static const spaceBetweenBossAndExamName = 8.0;
  static const spaceBetweenRoadmapAndExamName = 32.0;
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
  EdgeInsetsGeometry get examInfoMargin => EdgeInsets.only(
    left:
        leftAlignments.contains(alignment)
            ? spaceBetweenRoadmapAndExamName
            : spaceBetweenBossAndExamName,
    right:
        leftAlignments.contains(alignment)
            ? spaceBetweenBossAndExamName
            : spaceBetweenRoadmapAndExamName,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (textAlign == TextAlign.right) _buildExamInfo(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: spaceAboveBoss),
              // TODO REPLACE WITH ONTAP PARAM FUNCTION
              InkWell(
                onTap: () => context.push('/exam', extra: exam),
                splashColor: Colors.white38,
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(40.0),
                child: AnimatedBossSection(exam: exam, height: bossHeight, showOverlay: false),
              ),
              const SizedBox(height: spaceBetweenBossAndHealthBar),
              HealthBarSection(exam: exam),
              const SizedBox(height: spaceBelowHealthBar),
            ],
          ),
        ),
        if (textAlign == TextAlign.left) _buildExamInfo(),
      ],
    );
  }

  // TODO extract widget roadmap_boss_info ?
  Widget _buildExamInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        height: bossSectionHeight,
        alignment: alignment,
        margin: examInfoMargin,
        child: Text(
          exam.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: GoogleFonts.sixCaps(
            color: Colors.white.withAlpha((0.75 * 255).toInt()),
            fontWeight: FontWeight.w500,
            height: 1.0,
            fontSize: 36.0,
          ),
        ),
      ),
    );
  }
}
