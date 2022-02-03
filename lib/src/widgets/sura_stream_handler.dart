import 'dart:async';

import 'package:flutter/material.dart';

import 'sura_provider.dart';

class SuraStreamHandler<T> extends StatefulWidget {
  final Stream<T?> stream;

  ///A callback when Stream's snapshot hasData
  final Widget Function(T) ready;

  ///A widget that showing when stream's has no data
  final Widget? loading;

  ///stream initial data
  final T? initialData;

  ///On snapshot error callback
  final Widget Function(dynamic)? error;

  ///A function call when stream has an error
  final void Function(dynamic)? onError;

  ///create a StreamBuilder with less boilerplate code
  const SuraStreamHandler({
    Key? key,
    required this.stream,
    required this.ready,
    this.error,
    this.onError,
    this.loading,
    this.initialData,
  }) : super(key: key);

  @override
  _SuraStreamHandlerState<T> createState() => _SuraStreamHandlerState<T>();
}

class _SuraStreamHandlerState<T> extends State<SuraStreamHandler<T>> {
  SuraProvider? suraProvider;
  @override
  void initState() {
    if (widget.onError != null) {
      widget.stream.asBroadcastStream().listen((data) {}, onError: (err) {
        widget.onError?.call(err);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    suraProvider = SuraProvider.of(context);
    //
    return StreamBuilder<T?>(
      stream: widget.stream,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return widget.ready(snapshot.data!);
        } else if (snapshot.hasError) {
          if (widget.error != null) {
            return widget.error!(snapshot.error);
          }
          return suraProvider?.errorWidget?.call(snapshot.error, null) ??
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
          return suraProvider?.loadingWidget ??
              const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
