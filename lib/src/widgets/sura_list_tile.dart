import 'package:flutter/material.dart';
import 'package:sura_flutter/src/widgets/spacing.dart';

class SuraListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxDecoration? decoration;
  final CrossAxisAlignment? alignment;
  final Widget? separator;
  final double titleSpace;

  ///A custom ListTile for simple customization
  const SuraListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.decoration,
    this.onTap,
    this.trailing,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(0.0),
    this.alignment,
    this.separator,
    this.titleSpace = 32,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final titleWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.subtitle1!,
      child: title ?? const SizedBox(),
    );

    final subTitleWidget = DefaultTextStyle(
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Theme.of(context).textTheme.caption?.color),
      child: subtitle ?? const SizedBox(),
    );

    final trailingWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: trailing ?? const SizedBox(),
    );

    return Container(
      decoration: decoration,
      margin: margin,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            customBorder: RoundedRectangleBorder(
              borderRadius: decoration?.borderRadius ?? BorderRadius.zero,
            ),
            child: Padding(
              padding: padding,
              child: Row(
                crossAxisAlignment: alignment ?? CrossAxisAlignment.center,
                children: <Widget>[
                  if (leading != null) ...[
                    leading!,
                    SpaceX(titleSpace),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleWidget,
                        if (subtitle != null) const SpaceY(4),
                        subTitleWidget,
                      ],
                    ),
                  ),
                  const SpaceX(),
                  Flexible(
                    flex: 0,
                    child: trailingWidget,
                    fit: FlexFit.loose,
                  ),
                ],
              ),
            ),
          ),
          if (separator != null) separator!,
        ],
      ),
    );
  }
}
