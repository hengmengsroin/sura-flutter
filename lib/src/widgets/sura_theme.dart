import 'package:flutter/material.dart';

class SuraTheme extends InheritedWidget {
  const SuraTheme({
    Key key,
    @required Widget child,
    this.loadingWidget,
    this.buttonLoadingWidget,
  })  : assert(loadingWidget != null),
        assert(buttonLoadingWidget != null),
        super(key: key, child: child);

  final Widget loadingWidget;
  final Widget buttonLoadingWidget;

  static SuraTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraTheme>();
  }

  @override
  bool updateShouldNotify(SuraTheme old) => true;
}
