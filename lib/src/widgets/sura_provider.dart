import 'package:flutter/material.dart';

class SuraProvider extends InheritedWidget {
  const SuraProvider({
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
    this.onManagerError,
  }) : super(child: child);

  ///Loading widget use in [SuraAsyncButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [Manager] class
  final Widget? loadingWidget;

  ///Error widget use in [Manager] class
  final Widget Function(dynamic)? errorWidget;

  ///Error function call when manager error
  final void Function(dynamic, BuildContext)? onManagerError;

  static SuraProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraProvider>();
  }

  @override
  bool updateShouldNotify(SuraProvider old) => true;
}
