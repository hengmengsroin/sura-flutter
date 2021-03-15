import 'package:flutter/material.dart';
import 'package:sura_flutter/src/style/sura_decoration.dart';

import 'spacing.dart';

enum IconPosition {
  start,
  end,
}

///Custom accordion that similar to Flutter's [ExpansionTile]
class SuraAccordion extends StatefulWidget {
  final Widget title;
  final Widget icon;
  final List<Widget> children;
  final Curve curve;
  final Duration animationDuration;
  final BoxDecoration headerDecoration;
  final Color childrenBackgroundColor;
  final EdgeInsets headerPadding;
  final EdgeInsets margin;
  final EdgeInsets childrenPadding;
  final Function(bool) onToggle;
  final bool initiallyExpand;
  final bool showIcon;
  final bool animatedOnStart;
  final IconPosition iconPosition;

  const SuraAccordion({
    Key key,
    @required this.title,
    @required this.children,
    this.margin = const EdgeInsets.all(0.0),
    this.childrenPadding = const EdgeInsets.all(12.0),
    this.icon = const Icon(Icons.keyboard_arrow_down),
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 200),
    this.onToggle,
    this.headerPadding,
    this.headerDecoration,
    this.initiallyExpand = false,
    this.showIcon = true,
    this.iconPosition = IconPosition.end,
    this.childrenBackgroundColor,
    this.animatedOnStart = false,
  }) : super(key: key);
  @override
  _SuraAccordionState createState() => _SuraAccordionState();
}

class _SuraAccordionState extends State<SuraAccordion>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> size;
  Animation<double> rotation;

  void onToggle() {
    bool isExpand;
    if (controller.isAnimating) {
      return;
    } else if (controller.isCompleted) {
      controller.reverse();
      isExpand = false;
    } else {
      controller.forward();
      isExpand = true;
    }
    if (widget.onToggle != null) widget.onToggle(isExpand);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    if (widget.initiallyExpand) {
      widget.animatedOnStart ? controller.forward() : controller.value = 1.0;
    }
    size = CurvedAnimation(curve: widget.curve, parent: controller);
    rotation = Tween<double>(begin: 0.0, end: 0.5).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(SuraAccordion oldWidget) {
    if (widget.initiallyExpand != oldWidget.initiallyExpand) onToggle();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = RotationTransition(
      turns: rotation,
      child: widget.icon,
      alignment: Alignment.center,
    );

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            onTap: onToggle,
            customBorder: RoundedRectangleBorder(
              borderRadius: widget.headerDecoration?.borderRadius ??
                  SuraDecoration.radius(0),
            ),
            child: Ink(
              decoration: widget.headerDecoration,
              padding: widget.headerPadding ?? const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: widget.iconPosition == IconPosition.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.iconPosition == IconPosition.start &&
                      widget.showIcon) ...[
                    icon,
                    SpaceX(),
                  ],
                  Flexible(
                    child: DefaultTextStyle.merge(
                      child: widget.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  if (widget.iconPosition == IconPosition.end &&
                      widget.showIcon) ...[icon],
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: size,
            child: Container(
              color: widget.childrenBackgroundColor,
              padding: widget.childrenPadding,
              child: Column(
                children: widget.children,
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
