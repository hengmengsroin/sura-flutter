import 'package:flutter/material.dart';

import 'spacing.dart';

class SuraFlatButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double elevation;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final BorderSide? borderSide;

  ///A FlatButton with respectively small margin and shape
  const SuraFlatButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(8),
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.borderRadius,
    this.icon,
    this.borderSide,
    this.textColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      side: borderSide ?? BorderSide.none,
    );
    return Card(
      shape: shape,
      color: backgroundColor,
      elevation: elevation,
      margin: margin,
      child: InkWell(
        onTap: onPressed,
        customBorder: shape,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...[icon!, const SpaceX(8)],
              DefaultTextStyle.merge(
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: textColor),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
