import 'package:flutter/material.dart';
import 'package:sura_flutter/src/utils/sura_logger.dart';

import 'conditional_widget.dart';
import 'spacing.dart';
import 'sura_provider.dart';

/// SuraRaisedButton can be use sometime to replace RaisedButton or ElevatedButton because we provide more flexibility and wrap around
class SuraRaisedButton extends StatelessWidget {
  ///receive a ValueNotifier to indicate a loading widget
  final ValueNotifier<bool>? loadingNotifier;
  final Widget child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final Function? onLongPressed;
  final double? elevation;
  //Button's background Color
  final Color? color;
  final Color? textColor;
  //Loading indicator's color
  final Color loadingColor;
  final Widget? loadingWidget;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final OutlinedBorder? shape;
  final MainAxisAlignment? alignment;

  ///if [fullWidth] is `true`, Button will take all remaining horizontal space
  final bool fullWidth;
  final BorderSide? borderSide;
  final GlobalKey _globalKey = GlobalKey();

  ///Create a button with loading notifier
  SuraRaisedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.loadingColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.fullWidth = false,
    this.shape = const StadiumBorder(),
    this.elevation = 2.0,
    this.loadingNotifier,
    this.loadingWidget,
    this.color,
    this.textColor,
    this.icon,
    this.onLongPressed,
    this.alignment,
    this.borderSide,
  }) : super(key: key);

  void maintainWidthOnLoading() {
    if (fullWidth == false && width == null) {
      WidgetsBinding.instance?.addPostFrameCallback((d) {
        RenderBox box = _globalKey.currentContext!.findRenderObject() as RenderBox;
        width = box.size.width;
        infoLog(width);
      });
    }
  }

  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      color: Colors.transparent,
      margin: margin,
      child: ValueListenableBuilder<bool>(
        valueListenable: loadingNotifier ?? ValueNotifier(false),
        builder: (context, loading, _) {
          maintainWidthOnLoading();
          return ElevatedButton(
            onPressed: loading ? () {} : onPressed,
            style: ElevatedButton.styleFrom(
              shape: shape,
              primary: color,
              onPrimary: textColor,
              padding: padding,
              elevation: elevation,
              side: borderSide,
            ),
            onLongPress: loading ? () {} : () => onLongPressed?.call(),
            child: ConditionalWidget(
              condition: loading,
              onFalse: () => Row(
                key: _globalKey,
                mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (icon != null) ...[
                    icon ?? emptySizedBox,
                    const SpaceX(8),
                  ],
                  child,
                ],
              ),
              onTrue: () => loadingWidget ?? SuraProvider.of(context)?.buttonLoadingWidget ?? _buildLoadingWidget(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: width,
      child: Center(
        child: SizedBox(
          width: icon != null ? 24 : 20,
          height: icon != null ? 24 : 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
          ),
        ),
      ),
    );
  }
}
