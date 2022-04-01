import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class LoadingOverlayProvider {
  LoadingOverlayProvider._();

  static final LoadingOverlayProvider _instance = LoadingOverlayProvider._();
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  //
  static BuildContext? _context;

  ///Loading provider need a stable context, so it's best to initialize with
  ///the context that always active. eg. Builder context of MaterialApp
  ///If you're trying to use a custom context, sometime it will throw an error
  ///if our widget has been remove from a widget tree.
  static void init(BuildContext childContext) {
    if (_context != null) return;
    _context = childContext;
  }

  static void toggle([bool? value]) {
    if (_context == null) {
      throw FlutterError(
          "Please initialize a LoadingProvider with init() function");
    }
    _instance._toggleLoading(value);
  }

  void _toggleLoading([bool? value]) {
    _loadingNotifier.value = value ?? !_loadingNotifier.value;
  }
}

class LoadingOverlayBuilder extends StatelessWidget {
  final Widget child;

  ///A custom loading overlay widget.
  ///Default value is CircularProgessIndicator with Grey.02 background
  final Widget? loadingWidget;

  ///Create an LoadingOverlayProvider within this app
  const LoadingOverlayBuilder({
    Key? key,
    required this.child,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.withOpacity(0.2)
        : Colors.black26;
    return Builder(
      builder: (context) {
        LoadingOverlayProvider.init(context);
        return Stack(
          children: [
            child,
            ValueListenableBuilder<bool>(
              valueListenable:
                  LoadingOverlayProvider._instance._loadingNotifier,
              child: loadingWidget ??
                  Container(
                    child: const Center(child: CircularProgressIndicator()),
                    color: color,
                  ),
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return child!;
                }
                return emptySizedBox;
              },
            ),
          ],
        );
      },
    );
  }
}
