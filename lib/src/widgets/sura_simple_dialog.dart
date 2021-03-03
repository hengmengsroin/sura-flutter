import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/src/style/sura_style.dart';
import 'package:sura_flutter/src/widgets/sura_platform_checker.dart';

class SuraSimpleDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final Function onConfirm;
  final Widget child;
  final Color buttonColor;

  ///An alert dialog with title and content
  SuraSimpleDialog({
    this.child,
    this.content = "",
    this.title = "Information",
    this.confirmText = "OK",
    this.onConfirm,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SuraPlatformChecker(
      androidWidget: _buildAndroidDialog(context),
      iosWidget: _buildIOSDialog(context),
    );
  }

  Widget _buildIOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: child ??
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(content),
          ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(confirmText),
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  Widget _buildAndroidDialog(BuildContext context) {
    return AlertDialog(
      shape: SuraStyle.roundRect(16),
      title: Text(title),
      content: child ?? Text(content),
      actions: <Widget>[
        FlatButton(
          color: buttonColor,
          child: Text(confirmText),
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
