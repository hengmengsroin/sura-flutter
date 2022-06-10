import 'package:flutter/material.dart';

class SuraIconButton extends StatelessWidget {
  ///
  final VoidCallback? onTap;

  ///
  final Widget icon;

  ///
  final EdgeInsets margin;

  ///
  final EdgeInsets padding;

  ///
  final Color backgroundColor;

  ///
  final double borderRadius;

  ///
  final double elevation;

  ///
  final BorderSide? borderSide;

  ///
  final Widget? badge;

  ///An IconButton with respectively small margin and shape
  const SuraIconButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.borderSide,
    this.badge,
  }) : super(key: key);

  const SuraIconButton.action({
    Key? key,
    required this.onTap,
    required this.icon,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 32,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.borderSide,
    this.badge,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: borderSide ?? BorderSide.none,
    );

    return Card(
      shape: shape,
      color: backgroundColor,
      elevation: elevation,
      margin: margin,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        mouseCursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Padding(
              padding: padding,
              child: icon,
            ),
            if (badge != null)
              Positioned(
                child: badge!,
                top: 0,
                right: 0,
              ),
          ],
        ),
      ),
    );
  }
}
