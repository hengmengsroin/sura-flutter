import 'package:flutter/material.dart';

import '../../sura_flutter.dart';
import '../utils/type.dart';

enum LoadingType { progress, disable }

///Create a Material Elevated Button that can contain a [loadingWiidget] whenever you
///execute a Future function in [onPressed] callback
class SuraAsyncButton extends StatefulWidget {
  ///A [child] to display inside the button
  final Widget child;

  ///onPressed callback
  final AsyncCallback? onPressed;

  ///Button's margin, default value is [vertical: 16]
  final EdgeInsets margin;

  ///[startIcon] will show on the left side of the button
  final Widget? startIcon;

  ///[endIcon] will show on the left side of the button
  final Widget? endIcon;

  ///A widget to show when button is loading
  final Widget? loadingWidget;

  ///Button's widget
  final double? width;

  ///Button's height
  final double? height;

  ///Button's background color
  final Color? color;

  ///Button's text color
  final Color? textColor;

  ///A color for default [loadingWidget]
  final Color loadingColor;

  ///Button's shape
  final OutlinedBorder? shape;

  ///button's border side
  final BorderSide? borderSide;

  ///Button's elevation
  final double? elevation;

  ///Button padding
  final EdgeInsets padding;

  ///whether button is set to stretch with available width
  final bool fullWidth;

  /// select a loading type of the button
  final LoadingType loadingType;

  ///Alignment of the [icon] and [child]
  final MainAxisAlignment? alignment;

  ///Create a Material Elevated Button that can contain a [loadingWiidget] whenever you
  ///execute a Future function in [onPressed] callback
  const SuraAsyncButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.loadingColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.loadingType = LoadingType.progress,
    this.startIcon,
    this.endIcon,
    this.loadingWidget,
    this.width,
    this.height,
    this.color,
    this.shape,
    this.alignment,
    this.borderSide,
    this.textColor,
    this.elevation,
  }) : super(key: key);
  @override
  _SuraAsyncButtonState createState() => _SuraAsyncButtonState();
}

class _SuraAsyncButtonState extends State<SuraAsyncButton> {
  bool _isLoading = false;

  void onButtonPressed() async {
    if (_isLoading) return;
    try {
      toggleLoading();
      await widget.onPressed?.call();
    } catch (exception) {
      rethrow;
    } finally {
      toggleLoading();
    }
  }

  void toggleLoading() {
    if (mounted) setState(() => _isLoading = !_isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasIcon = widget.startIcon != null || widget.endIcon != null;
    final Widget buttonContent = Row(
      mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: hasIcon ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.startIcon != null) ...[
          widget.startIcon!,
          const SpaceX(),
        ],
        widget.child,
        if (widget.endIcon != null) ...[
          const SpaceX(),
          widget.endIcon!,
        ],
      ],
    );

    final Widget loadingWidget = widget.loadingWidget ??
        SuraProvider.of(context)?.buttonLoadingWidget ??
        _buildLoadingWidget();

    return Container(
      height: widget.height,
      width: widget.fullWidth ? double.infinity : widget.width,
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: _isLoading
            ? widget.loadingType == LoadingType.disable
                ? null
                : () {}
            : widget.onPressed != null
                ? onButtonPressed
                : null,
        child: ConditionalWidget(
          condition: _isLoading,
          onTrue: () => widget.loadingType == LoadingType.disable
              ? buttonContent
              : loadingWidget,
          onFalse: () => buttonContent,
        ),
        style: ElevatedButton.styleFrom(
          shape: widget.shape,
          padding: widget.padding,
          primary: widget.color,
          onPrimary: widget.textColor,
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
