import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(context, Icons.remove, onMinusClick),
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
            Text('minutes', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        Spacer(),
        _buildIconButton(context, Icons.add, onPlusClick),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    IconData icon,
    StudyTimerAction? action,
  ) => IconButton(
    onPressed: action,
    style: IconButton.styleFrom(
      backgroundColor: Colors.white38,
      shadowColor: Theme.of(context).colorScheme.shadow.withAlpha(32),
      elevation: 2,
      padding: EdgeInsets.all(0),
      minimumSize: Size.fromRadius(16.0),
      highlightColor: Theme.of(context).colorScheme.onPrimary.withAlpha(128),
    ),
    icon: Icon(
      icon,
      size: 24.0,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}
