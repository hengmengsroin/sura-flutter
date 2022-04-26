import 'package:flutter/material.dart';

import '../utils/type.dart';
import 'conditional_widget.dart';
import 'sura_provider.dart';

class SuraAsyncIconButton extends StatefulWidget {
  final FutureOrCallBack? onTap;
  final Widget icon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;

  ///Button's borderRadius, You can check [borderRadius] documentation on Flutter
  final double borderRadius;

  ///Button's elevation, You can check [elevation] documentation on Flutter
  final double elevation;

  ///Border side of the button, You can check [borderSide] documentation on Flutter
  final BorderSide? borderSide;

  ///Small badge shown similar to Notification badge
  final Widget? badge;

  ///A widget to show when button is loading
  ///Using LoadingWidget from SuraProvider or default CircularProgressIndicator with 24px
  final Widget? loadingWidget;

  ///An IconButton with respectively small margin and shape
  const SuraAsyncIconButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.borderSide,
    this.badge,
    this.loadingWidget,
  }) : super(key: key);

  @override
  State<SuraAsyncIconButton> createState() => _SuraAsyncIconButtonState();
}

class _SuraAsyncIconButtonState extends State<SuraAsyncIconButton> {
  bool _isLoading = false;

  void onButtonPressed() async {
    if (_isLoading) return;
    try {
      toggleLoading();
      await widget.onTap?.call();
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
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      side: widget.borderSide ?? BorderSide.none,
    );

    final Widget loadingWidget = widget.loadingWidget ??
        SuraProvider.of(context)?.buttonLoadingWidget ??
        const CircularProgressIndicator();

    final Widget buttonContent = Stack(
      children: [
        Padding(
          padding: widget.padding,
          child: widget.icon,
        ),
        if (widget.badge != null)
          Positioned(
            child: widget.badge!,
            top: 0,
            right: 0,
          ),
      ],
    );

    const double defaultIconSize = 24;

    return Card(
      shape: shape,
      color: widget.backgroundColor,
      elevation: widget.elevation,
      margin: widget.margin,
      child: InkWell(
        onTap: onButtonPressed,
        customBorder: shape,
        child: ConditionalWidget(
          condition: _isLoading,
          onTrue: () => Padding(
            padding: widget.padding,
            child: SizedBox(
              child: loadingWidget,
              width: defaultIconSize,
              height: defaultIconSize,
            ),
          ),
          onFalse: () => buttonContent,
        ),
      ),
    );
  }
}
