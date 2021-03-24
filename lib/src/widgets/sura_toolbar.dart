import 'package:flutter/material.dart';

///Custom AppBar or ToolBar that often use if you're only need a [BackButton] for pop navigator or
///define a custom toolbar
class SuraToolbar extends StatelessWidget {
  final Icon icon;
  final Color iconColor;

  ///A String similar to AppBar's title
  final String title;
  final TextStyle titleStyle;

  ///A callback when BackButton is Pressed, Default action is to Pop the context
  final Function onTap;
  final Color backgroundColor;

  ///Alignment of the header
  final Alignment titleAlignment;

  //elevation of the header
  final double elevation;

  final double titleMargin = 56.0;

  ///Create a Custom App Bar like Back Button with Header support
  SuraToolbar({
    this.onTap,
    this.title,
    this.titleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    this.icon,
    this.titleAlignment = Alignment.center,
    this.backgroundColor = Colors.transparent,
    this.iconColor,
    this.elevation = 0.0,
  });
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
                          icon: icon,
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
                      title,
                      style:
                          titleStyle ?? Theme.of(context).textTheme.headline6,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
