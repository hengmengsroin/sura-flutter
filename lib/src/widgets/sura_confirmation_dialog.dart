import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sura_flutter.dart';

///A dialog that provide onCancel and Confirm action
class SuraConfirmationDialog extends StatelessWidget {
  final Widget content;
  final String title;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  ///Swap position of confirm button and cancel button
  final bool swapButtonsPosition;

  ///A dialog that provide onCancel and Confirm action
  SuraConfirmationDialog({
    required this.content,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.title = "Confirmation",
    this.onCancel,
    this.onConfirm,
    this.swapButtonsPosition = false,
  });

  @override
  Widget build(BuildContext context) {
    return SuraPlatformChecker(
      androidWidget: _buildAndroidDialog(context),
      iosWidget: _buildIOSDialog(context),
    );
  }

  Widget _buildIOSDialog(BuildContext context) {
    final List<Widget> actions = <Widget>[
      CupertinoDialogAction(
        child: Text(cancelText),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.of(context).pop(false);
          onCancel?.call();
        },
      ),
      CupertinoDialogAction(
        child: Text(confirmText),
        onPressed: () {
          Navigator.of(context).pop(true);
          onConfirm?.call();
        },
      ),
    ];

    if (swapButtonsPosition) {
      Widget temp = actions[0];
      actions[0] = actions[1];
      actions[1] = temp;
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: content.margin(EdgeInsets.only(top: 12)),
      actions: actions,
    );
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final List<Widget> actions = <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.red,
        ),
        child: Text(cancelText),
        onPressed: () {
          Navigator.of(context).pop(false);
          onCancel?.call();
        },
      ),
      TextButton(
        child: Text(confirmText),
        onPressed: () {
          Navigator.of(context).pop(true);
          onConfirm?.call();
        },
      ),
    ];
    if (swapButtonsPosition) {
      Widget temp = actions[0];
      actions[0] = actions[1];
      actions[1] = temp;
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}
