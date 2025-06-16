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
    this.maxHeight = 200,
    this.alignment = Alignment.center,
    this.color = Colors.white,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: maxHeight),
      margin: margin,
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
        child: Text(
          text,
          style: GoogleFonts.sixCaps(
            color: color.withAlpha((opacity * 255).toInt()),
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
