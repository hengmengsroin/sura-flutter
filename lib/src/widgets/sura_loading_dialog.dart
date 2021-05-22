import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sura_theme.dart';

class SuraLoadingDialog {
  final bool dismissible;
  final BuildContext context;
  BuildContext? _dialogContext;

  SuraLoadingDialog(
    this.context, {
    this.dismissible = false,
  });

  Future<void> show({Widget? child}) async {
    final dialogChild = child ?? SuraTheme.of(context)?.loadingWidget ?? CircularProgressIndicator();
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (dialogContext) {
          this._dialogContext = dialogContext;
          return WillPopScope(
            onWillPop: () async {
              if (dismissible) _dialogContext = null;
              return dismissible;
            },
            child: Dialog(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: dialogChild,
                ),
                widthFactor: 1.0,
                heightFactor: 1.0,
              ),
            ),
          );
        });
    await Future.delayed(Duration(milliseconds: 500));
  }

  void hide() async {
    if (_dialogContext != null) Navigator.of(_dialogContext!).pop();
  }
}
