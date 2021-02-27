import 'package:flutter/material.dart';

class SuraNotifier<T> extends StatelessWidget {
  final ValueNotifier<T> valueNotifier;
  final Widget Function(T) builder;

  //A ValueListenableBuilder with cleaner look code
  const SuraNotifier({
    Key key,
    @required this.valueNotifier,
    @required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: valueNotifier,
      builder: (context, T data, _) {
        return builder(data);
      },
    );
  }
}
