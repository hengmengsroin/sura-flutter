import 'package:flutter/material.dart';

class SuraTheme extends InheritedWidget {
  const SuraTheme({
    Key key,
    @required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
  }) : super(key: key, child: child);

  final Widget loadingWidget;
  final Widget buttonLoadingWidget;
  final Widget Function(dynamic) errorWidget;

  static SuraTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraTheme>();
  }

  @override
  bool updateShouldNotify(SuraTheme old) => true;
}
