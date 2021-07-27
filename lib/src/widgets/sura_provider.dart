import 'package:flutter/material.dart';
import '../utils/type.dart';

class SuraProvider extends InheritedWidget {
  const SuraProvider({
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
  }) : super(child: child);

  ///Loading widget use in [SuraAsyncButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [Manager] class
  final Widget? loadingWidget;

  ///Error widget use in [Manager] class
  final CustomErrorWidget? errorWidget;

  static SuraProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuraProvider>();
  }

  @override
  bool updateShouldNotify(SuraProvider old) => true;
}
