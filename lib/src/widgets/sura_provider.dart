import 'package:flutter/material.dart';

import '../utils/type.dart';

class SuraProvider extends InheritedWidget {
  const SuraProvider({
    Key? key,
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
  }) : super(child: child, key: key);

  ///Loading widget use in [SuraAsyncButton,SuraAsyncIconButton and SuraRaisedButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [SuraFutureHandler,SuraStreamHandler] class
  final Widget? loadingWidget;

  ///Error widget use in [SuraFutureHandler,SuraStreamHandler] class
  final CustomErrorWidget? errorWidget;

  static SuraProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraProvider>();
  }

  @override
  bool updateShouldNotify(SuraProvider oldWidget) => true;
}
