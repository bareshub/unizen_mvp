import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/exam/exam.dart';
import '../../animated_scene/animated_scene.dart';
import 'overlay_text.dart';

class AnimatedBossSection extends StatelessWidget {
  const AnimatedBossSection({
    super.key,
    required this.exam,
    required this.height,
    this.width = double.infinity,
    this.externalElapsed,
    this.showOverlay = true,
    this.overlayMargin,
  }) : assert(overlayMargin == null || showOverlay);

  final Exam exam;
  final double height;
  final double width;
  final ValueListenable<Duration>? externalElapsed;
  final bool showOverlay;
  final EdgeInsetsGeometry? overlayMargin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (showOverlay) OverlayText(exam.name, margin: overlayMargin),
        SizedBox(
          width: width,
          height: height,
          child: AnimatedSceneWidget(
            exam: exam,
            externalElapsed: externalElapsed,
          ),
        ),
      ],
    );
  }
}
