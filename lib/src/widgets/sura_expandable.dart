import 'package:flutter/material.dart';

///A widget that provide that can hide bottomContent
class SuraExpandable extends StatefulWidget {
  final Widget topChild;
  final Widget bottomChild;
  final Duration duration;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Curve curve;
  final bool initiallyExpand;
  final Function(bool) onToggle;
  final bool animatedOnStart;
  const SuraExpandable({
    Key key,
    @required this.topChild,
    @required this.bottomChild,
    this.initiallyExpand = false,
    this.duration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.all(16),
    this.curve = Curves.linear,
    this.margin = EdgeInsets.zero,
    this.onToggle,
    this.animatedOnStart = false,
  }) : super(key: key);
  @override
  _SuraExpandableState createState() => _SuraExpandableState();
}

class _SuraExpandableState extends State<SuraExpandable>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> size;

  void toggle() {
    if (controller.isAnimating) {
      return;
    } else if (controller.isCompleted) {
      widget.onToggle?.call(false);
      controller.reverse();
    } else {
      widget.onToggle?.call(true);
      controller.forward();
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.initiallyExpand) {
      widget.animatedOnStart ? controller.forward() : controller.value = 1.0;
    }
    size = CurvedAnimation(curve: widget.curve, parent: controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SuraExpandable oldWidget) {
    if (widget.initiallyExpand != oldWidget.initiallyExpand) toggle();
    super.didUpdateWidget(oldWidget);
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
            onTap: toggle,
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
