import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuraActionSheet<T> extends StatelessWidget {
  ///When you tap on [options], it will return it's index value as a result
  final List<T> options;
  final String title;
  final String cancelText;
  final void Function(T option, int index) onSelected;
  final Widget Function(T option, int index) builder;
  //Create a cupertino bottom sheet with list of option
  const SuraActionSheet({
    Key key,
    @required this.builder,
    @required this.title,
    this.options,
    this.cancelText = "Cancel",
    this.onSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      message: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      actions: List.generate(options.length, (index) {
        final T option = options[index];
        return CupertinoActionSheetAction(
          child: builder.call(option, index),
          onPressed: () {
            Navigator.pop(context, index);
            onSelected?.call(option, index);
          },
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        child: Text(cancelText),
        isDestructiveAction: true,
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, -1);
        },
      ),
    );
  }
}
