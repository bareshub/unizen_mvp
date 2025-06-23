import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_icon_button.dart';

typedef StudyTimerAction = void Function();

class StudyTimerControls extends StatelessWidget {
  const StudyTimerControls({
    super.key,
    required this.minutes,
    required this.onPlusClick,
    required this.onMinusClick,
  });

  final int minutes;
  final StudyTimerAction? onPlusClick;
  final StudyTimerAction? onMinusClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FrostedGlassIconButton(icon: Icons.remove, action: onMinusClick),
          Spacer(),
          Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.9,
                        end: 1.0,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  '$minutes',
                  key: ValueKey<int>(minutes),
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 40.0),
                ),
              ),
              SizedBox(width: 4.0),
              Text('Minutes', style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          Spacer(),
          FrostedGlassIconButton(icon: Icons.add, action: onPlusClick),
        ],
      ),
    );
  }
}
