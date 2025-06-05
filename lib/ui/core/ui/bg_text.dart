import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BgText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const BgText({super.key, required this.text, this.margin, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedColor = color ?? theme.colorScheme.onPrimary.withAlpha(64);

    return Container(
      margin: margin,
      width: double.infinity,
      child: FittedBox(
        alignment: Alignment.bottomCenter,
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          style: GoogleFonts.sixCaps(
            color: resolvedColor,
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
