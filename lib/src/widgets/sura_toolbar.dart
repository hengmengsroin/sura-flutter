import 'package:flutter/material.dart';

///Custom AppBar or ToolBar that often use if you're only need a [BackButton] for pop navigator or
///define a custom toolbar
class SuraToolbar extends StatelessWidget {
  ///Leading icon for IconButton
  final Widget? icon;

  ///BackButton iconColor if user doesn't use custom [icon]
  final Color? iconColor;

  ///A String similar to AppBar's title
  final String? title;

  ///A style for title
  final TextStyle? titleStyle;

  ///A callback when BackButton is Pressed, Default action is to Pop the Navigator
  final VoidCallback? onTap;

  ///Toolbar background color
  final Color? backgroundColor;

  ///Alignment of the header. Default to [center]
  final Alignment titleAlignment;

  ///elevation of the Toolbar
  final double elevation;

  ///Margin left of the [icon] if Alignment is to the Left
  final double titleMargin = 56.0;

  final List<Widget>? actions;

  ///Create a Custom App Bar like Back Button with Header support
  const SuraToolbar({
    Key? key,
    this.title,
    this.titleStyle,
    this.onTap,
    this.actions,
    this.icon,
    this.iconColor,
    this.titleAlignment = Alignment.center,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      child: SafeArea(
        bottom: false,
        child: Container(
          alignment: Alignment.center,
          height: kToolbarHeight,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: icon != null
                      ? IconButton(
                          icon: icon!,
                          onPressed: onTap ?? () => Navigator.of(context).pop(),
                        )
                      : BackButton(
                          color: iconColor ?? Theme.of(context).iconTheme.color,
                        ),
                ),
              ),
              if (title != null)
                Align(
                  alignment: titleAlignment,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: titleAlignment == Alignment.centerLeft
                            ? titleMargin + 16
                            : 0),
                    child: Text(
                      title!,
                      style:
                          titleStyle ?? Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              if (actions != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
