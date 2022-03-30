import 'package:flutter/material.dart';

extension SuraListenableExtension on Listenable {
  Widget build({required Widget Function() child}) {
    return AnimatedBuilder(
      animation: this,
      builder: (context, _) {
        return child();
      },
    );
  }

  Widget builder({required TransitionBuilder builder, Widget? child}) {
    return AnimatedBuilder(
      animation: this,
      child: child,
      builder: builder,
    );
  }
}
