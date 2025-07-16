import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UnizenLogo extends StatelessWidget {
  const UnizenLogo({super.key, this.version = 1, this.size = 64, this.color});

  final int version;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/unizen_logo_v$version.svg',
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).colorScheme.onPrimary,
        BlendMode.srcIn,
      ),
      width: size,
    );
  }
}
