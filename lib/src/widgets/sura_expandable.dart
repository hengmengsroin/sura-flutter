import 'package:flutter/material.dart';

class SuraExpandable extends StatefulWidget {
  ///
  final Widget topChild;

  ///
  final Widget bottomChild;

  ///
  final Duration duration;

  ///
  final EdgeInsets padding;

  ///
  final EdgeInsets margin;

  ///Animation's curve
  final Curve curve;

  ///
  final bool value;

  ///
  final ValueChanged<bool> onToggle;

  ///
  final bool animatedOnStart;

  ///A widget that provide that can hide bottomContent
  const SuraExpandable({
    Key? key,
    required this.topChild,
    required this.bottomChild,
    required this.value,
    required this.onToggle,
    this.duration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.all(16),
    this.curve = Curves.linear,
    this.margin = EdgeInsets.zero,
    this.animatedOnStart = false,
  }) : super(key: key);
  @override
  _SuraExpandableState createState() => _SuraExpandableState();
}

class _SuraExpandableState extends State<SuraExpandable>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> size;

  void onToggleAnimation() {
    if (controller.isAnimating) return;
    if (widget.value) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.value) {
      widget.animatedOnStart ? controller.forward() : controller.value = 1.0;
    }
    size = CurvedAnimation(curve: widget.curve, parent: controller);
    super.initState();
  }

  @override
  void didUpdateWidget(SuraExpandable oldWidget) {
    if (widget.value != oldWidget.value) {
      onToggleAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: widget.topChild,
            onTap: () => widget.onToggle(!widget.value),
          ),
          SizeTransition(
            child: widget.bottomChild,
            sizeFactor: size,
          ),
        ],
      ),
    );
  }
}
