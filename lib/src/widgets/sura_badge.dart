import 'package:flutter/material.dart';

class SuraBadge extends StatelessWidget {
  final double radius;
  final String text;
  final Color color;
  const SuraBadge({
    Key? key,
    this.radius = 6.0,
    this.text = "",
    this.color = Colors.red,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
  }
}
