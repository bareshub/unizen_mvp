import 'package:flutter/material.dart';

class ZCard extends StatelessWidget {
  final EdgeInsets? padding;
  final Border? border;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Color? shadowColor;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final EdgeInsets? margin;
  final Widget? child;

  const ZCard({
    super.key,
    this.child,
    this.padding,
    this.border,
    this.borderColor,
    this.borderRadius,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      margin: margin ?? EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        // border: border ?? Border.all(color: Colors.grey.shade300, width: 0.0),
        color: borderColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor ?? Colors.grey.shade300,
            blurRadius: shadowBlurRadius ?? 3.0,
            offset: shadowOffset ?? Offset(0.0, 0.0),
          ),
        ],
      ),
      child: child ?? Scaffold(),
    );
  }
}
