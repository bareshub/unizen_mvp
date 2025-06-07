import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_models/health_bar_view_model.dart';

class HealthBar extends StatefulWidget {
  const HealthBar({super.key, required this.viewModel, this.margin});

  final HealthBarViewModel viewModel;
  final EdgeInsetsGeometry? margin;

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          width: double.infinity,
          height: widget.viewModel.config.size.height,
          margin: widget.margin,
          // TODO move container BoxDecoration in Theme
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white54,
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: widget.viewModel.health,
            builder: (context, health, _) {
              final maxHealth = widget.viewModel.maxHealth.value;

              final healthFactor = 1.0 / maxHealth * health;

              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: healthFactor,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(6.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      // TODO update based on healthPercentage
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepOrange,
                          width: 1.5,
                        ),
                        color: Colors.deepOrange.withAlpha(156),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3.0),
                            child: FittedBox(
                              child: Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              '2539',
                              style: GoogleFonts.rubik(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
