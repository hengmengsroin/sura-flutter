import 'package:flutter/material.dart';

import 'spacing.dart';

///A badge that often us in fpr notification
class SuraBadge extends StatelessWidget {
  final double radius;
  final String text;
  final Color color;
  final bool enable;

  ///A badge that often us in fpr notification
  const SuraBadge({
    Key? key,
    this.radius = 6.0,
    this.text = "",
    this.color = Colors.red,
    this.enable = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!enable) return emptySizedBox;
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
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
  }
}
