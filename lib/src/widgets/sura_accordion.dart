import 'package:flutter/material.dart';
import 'package:sura_flutter/src/style/sura_decoration.dart';

import 'spacing.dart';

enum IconPosition {
  start,
  end,
}

///Custom accordion that similar to Flutter's [ExpansionTile]
class SuraAccordion extends StatefulWidget {
  ///Accordion title, usually a Text
  final Widget title;

  ///A trailing icon that rotate on expanded or collapse
  final Widget icon;

  ///A widgets that show after the widget has expended
  final List<Widget> children;

  ///Animation curve when you click to expand or collapse the Accordion
  final Curve curve;

  ///Duration of the animation process
  final Duration animationDuration;

  ///Decoration of the title
  final BoxDecoration? titleDecoration;

  ///Background color of the wrapping children widgets
  final Color? childrenBackgroundColor;

  ///Padding of the title, default value is [EdgeInsets.all(16)]
  final EdgeInsets? titlePadding;

  ///Margin of this widget
  final EdgeInsets margin;

  ///Padding of the children widgets
  final EdgeInsets childrenPadding;

  ///A callback function that call on every toggle
  final Function(bool)? onToggle;

  ///a condition if to expand to Accordion on initial
  final bool initiallyExpand;

  ///Check if to show the trailing icon
  final bool showIcon;

  ///Check if to run the toggle animation on initial
  final bool animatedOnStart;

  ///Position of the trailing icon
  final IconPosition iconPosition;

  ///Custom accordion that similar to Flutter's [ExpansionTile]
  const SuraAccordion({
    Key? key,
    required this.title,
    required this.children,
    this.margin = const EdgeInsets.all(0.0),
    this.childrenPadding = const EdgeInsets.all(12.0),
    this.icon = const Icon(Icons.keyboard_arrow_down),
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 200),
    this.onToggle,
    this.titlePadding,
    this.titleDecoration,
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
  late AnimationController controller;
  late Animation<double> size;
  late Animation<double> rotation;

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
    if (widget.onToggle != null) widget.onToggle!(isExpand);
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
              borderRadius: widget.titleDecoration?.borderRadius ??
                  SuraDecoration.radius(0),
            ),
            child: Ink(
              decoration: widget.titleDecoration,
              padding: widget.titlePadding ?? const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: widget.iconPosition == IconPosition.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.iconPosition == IconPosition.start &&
                      widget.showIcon) ...[
                    icon,
                    const SpaceX(),
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
