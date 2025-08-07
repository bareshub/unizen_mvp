import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/liquid_glass_box.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 32.0,
          height: 660.0,
          child: LiquidGlassBox(child: Container()),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 24.0,
            height: 500.0,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    );
  }
}
