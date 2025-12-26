import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A decorative background or overlay text widget.
class OverlayText extends StatelessWidget {
  const OverlayText(
    this.text, {
    super.key,
    this.opacity = 0.35,
    this.maxHeight = 200,
    this.maxLines = 2,
    this.alignment = Alignment.bottomCenter,
    this.color = Colors.white,
    this.fontSize,
    this.margin,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final double opacity;
  final double maxHeight;
  final int maxLines;
  final AlignmentGeometry alignment;
  final Color color;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final overlayText = Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.sixCaps(
        color: color.withAlpha((opacity * 255).toInt()),
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        height: 1.0,
        letterSpacing: 0,
      ),
    );
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: maxHeight),
      margin: margin,
      child:
          fontSize == null
              ? FittedBox(
                fit: BoxFit.contain,
                alignment: alignment,
                child: overlayText,
              )
              : overlayText,
    );
  }
}
