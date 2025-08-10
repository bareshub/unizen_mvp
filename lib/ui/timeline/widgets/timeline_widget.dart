import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/liquid_glass_box.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 28.0,
          height: 100.0,
          child: Transform.rotate(
            angle: pi / 8,
            child: LiquidGlassBox(child: Container()),
          ),
        ),
        Transform.rotate(
          angle: pi / 8,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 20.0,
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
