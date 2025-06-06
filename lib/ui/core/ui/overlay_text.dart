import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A decorative background or overlay text widget.
class OverlayText extends StatelessWidget {
  final String text;
  final double opacity;
  final double maxHeight;
  final Alignment alignment;
  final Color color;
  final EdgeInsetsGeometry? margin;

  const OverlayText(
    this.text, {
    super.key,
    this.opacity = 0.25,
    this.maxHeight = 100,
    this.alignment = Alignment.center,
    this.color = Colors.white,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: FittedBox(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: GoogleFonts.sixCaps(
              color: color.withAlpha(opacity * 255 as int),
              fontWeight: FontWeight.w500,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
