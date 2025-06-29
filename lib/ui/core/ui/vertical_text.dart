import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({
    super.key,
    required this.text,
    required this.alignment,
    this.color,
    this.padding = const EdgeInsets.all(8.0),
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
                .toUpperCase()
                .split('')
                .map(
                  (string) => Text(
                    string,
                    style: GoogleFonts.jetBrainsMonoTextTheme().labelSmall
                        ?.copyWith(
                          color:
                              color ?? Theme.of(context).colorScheme.onSurface,
                          fontSize: 12.0,
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
