import 'package:flutter/material.dart';

class HealthBar extends StatefulWidget {
  const HealthBar({super.key});

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 90),
      height: 22,
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(width: 1.0, color: Colors.grey.shade600),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 3.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(2, 2, 100, 2),
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange.shade800,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          spacing: 4,
          children: [
            Icon(Icons.favorite_rounded, color: Colors.white, size: 8),
            Text(
              '2530',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
