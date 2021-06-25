import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sura_provider.dart';

class SuraFutureHandler<T> extends StatefulWidget {
  ///Future to check on
  final Future<T>? future;
  final Future<T> Function()? futureFunction;

  ///A callback when Future's snapshot hasData
  final Widget Function(T) ready;
  final Widget? loading;
  final T? initialData;

  ///On snapshot error callback
  final Widget Function(dynamic)? error;

  ///Create a futurebuilder with less boilerplate code
  const SuraFutureHandler({
    required this.future,
    required this.ready,
    this.error,
    this.futureFunction,
    this.loading,
    this.initialData,
  });

  const SuraFutureHandler.function({
    required this.ready,
    required this.futureFunction,
    this.future,
    this.error,
    this.loading,
    this.initialData,
  });

  @override
  _SuraFutureHandlerState<T> createState() => _SuraFutureHandlerState<T>();
}

class _SuraFutureHandlerState<T> extends State<SuraFutureHandler<T>> {
  Future<T>? future;

  @override
  void initState() {
    future = widget.future ?? widget.futureFunction?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SuraProvider? suraTheme = SuraProvider.of(context);
    //
    return FutureBuilder<T>(
      future: widget.future,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.ready(snapshot.data!);
        } else if (snapshot.hasError) {
          if (widget.error != null) {
            return widget.error!(snapshot.error);
          }
          return suraTheme?.errorWidget?.call(snapshot.error) ??
              Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              );
        } else {
          if (widget.loading != null) {
            return widget.loading!;
          }
          return suraTheme?.loadingWidget ?? Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
