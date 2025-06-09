import 'package:flutter/material.dart';

class HealthBarContent extends StatelessWidget {
  const HealthBarContent({super.key, required this.health, this.margin});

  final int health;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.favorite_rounded, color: Colors.white),
            ),
          ),
          FittedBox(
            child: Text(
              health.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
