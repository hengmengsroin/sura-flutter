import 'dart:async';

import 'package:flutter/material.dart';

import 'conditional_widget.dart';
import 'spacing.dart';

enum LoadingType { Progress, Disable }

class SuraAsyncButton extends StatefulWidget {
  ///A [child] to display inside the button
  final Widget child;

  ///onPressed callback
  final FutureOr<void> Function() onPressed;

  ///[startIcon] will show on the left side of the button
  final Widget startIcon;

  ///[endIcon] will show on the left side of the button
  final Widget endIcon;

  ///A widget to show when button is loading
  final Widget loadingWidget;

  final double width;

  final double height;

  ///Button's background color
  final Color color;

  ///A color for default [loadingWidget]
  final Color loadingColor;

  final ShapeBorder shape;

  final BorderSide borderSide;

  final double elevation;

  ///Button's margin, default value is [vertical: 16]
  final EdgeInsets margin;
  final EdgeInsets padding;

  ///whether button is set to stretch with available width
  final bool fullWidth;

  /// select a loading type of the button
  final LoadingType loadingType;

  final MainAxisAlignment alignment;

  const SuraAsyncButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.fullWidth = true,
    this.loadingColor = Colors.white,
    this.elevation = 2,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.loadingType = LoadingType.Progress,
    this.startIcon,
    this.endIcon,
    this.loadingWidget,
    this.width,
    this.height,
    this.color,
    this.shape,
    this.alignment,
    this.borderSide,
  }) : super(key: key);
  @override
  _SuraAsyncButtonState createState() => _SuraAsyncButtonState();
}

class _SuraAsyncButtonState extends State<SuraAsyncButton> {
  bool isLoading = false;

  void onButtonPressed() async {
    if (isLoading) return;
    try {
      toggleLoading();
      await widget.onPressed?.call();
    } catch (exception) {
      throw exception;
    } finally {
      toggleLoading();
    }
  }

  void toggleLoading() {
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = Row(
      mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.startIcon != null) ...[
          widget.startIcon,
          SpaceX(),
        ],
        widget.child,
        if (widget.endIcon != null) ...[
          SpaceX(),
          widget.endIcon,
        ],
      ],
    );

    final Widget loadingWidget = widget.loadingWidget ?? _buildLoadingWidget();

    return Container(
      height: widget.height,
      width: widget.fullWidth ? double.infinity : widget.width,
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: isLoading
            ? widget.loadingType == LoadingType.Disable
                ? null
                : () {}
            : widget.onPressed != null
                ? this.onButtonPressed
                : null,
        child: ConditionalWidget(
          condition: isLoading,
          onTrue: () => widget.loadingType == LoadingType.Disable
              ? buttonContent
              : loadingWidget,
          onFalse: () => buttonContent,
        ),
        style: ElevatedButton.styleFrom(
          shape: widget.shape,
          padding: widget.padding,
          primary: widget.color,
          side: widget.borderSide,
          elevation: widget.elevation,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: widget.startIcon != null ? 24 : 20,
      height: widget.startIcon != null ? 24 : 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.loadingColor),
      ),
    );
  }
}
