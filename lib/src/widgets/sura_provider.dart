import 'package:flutter/material.dart';
import '../utils/type.dart';


typedef OnManagerError = Function(error, BuildContext context);

class SuraProvider extends InheritedWidget {
  const SuraProvider({
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
    this.onFutureManagerError,
  }) : super(child: child);

  ///Loading widget use in [SuraAsyncButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [Manager] class
  final Widget? loadingWidget;

  ///Error widget use in [Manager] class
  final CustomErrorWidget? errorWidget;

  //A callback function that run if FutureManagerBuilder has an error
  final OnManagerError? onFutureManagerError;

  static SuraProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraProvider>();
  }

  @override
  bool updateShouldNotify(SuraProvider old) => true;
}
