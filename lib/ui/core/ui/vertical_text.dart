import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({
    super.key,
    required this.text,
    required this.alignment,
    this.color,
    this.padding = const EdgeInsets.all(4.0),
  });

  final Alignment alignment;
  final String text;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        children:
            text
                .split("")
                .map(
                  (string) => Text(
                    string,
                    style: TextStyle(
                      color: color ?? Theme.of(context).colorScheme.onSurface,
                      fontFamily: "monospace",
                      fontSize: 12.0,
                      fontFamilyFallback: const <String>["Courier"],
                      height: 0.8,
                      letterSpacing: 0,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
