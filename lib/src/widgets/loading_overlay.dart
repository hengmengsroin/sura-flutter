import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class LoadingOverlayProvider extends InheritedWidget {
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  //
  static BuildContext? _context;
  LoadingOverlayProvider({Key? key, required Widget child}) : super(key: key, child: child);

  ///Loading provider need a stable context, so it's best to initialize with
  ///the context that always active. eg. Builder context of MaterialApp
  ///If you're trying to use a custom context, sometime it will throw an error
  ///if our widget has been remove from a widget tree.
  static void init(BuildContext childContext) {
    if (_context != null) return;
    _context = childContext;
  }

  bool get isLoading => _loadingNotifier.value;

  static LoadingOverlayProvider? of(BuildContext context) {
    if (_context == null) {
      throw FlutterError("Please wrap your MaterialApp or MaterialApp builder with LoadingOverlayBuilder");
    }
    return context.dependOnInheritedWidgetOfExactType<LoadingOverlayProvider>();
  }

  static void toggle([bool? value]) {
    if (_context == null) {
      throw FlutterError("Please wrap your MaterialApp or MaterialApp builder with LoadingOverlayBuilder");
    }
    LoadingOverlayProvider.of(_context!)!._toggleLoading(value);
  }

  void _toggleLoading([bool? value]) {
    _loadingNotifier.value = value ?? !_loadingNotifier.value;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
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
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.2) : Colors.black26;
    return LoadingOverlayProvider(
      child: Builder(
        builder: (context) {
          LoadingOverlayProvider.init(context);
          LoadingOverlayProvider overlayProvider = LoadingOverlayProvider.of(context)!;
          return Stack(
            children: [
              child,
              ValueListenableBuilder<bool>(
                valueListenable: overlayProvider._loadingNotifier,
                child: loadingWidget ??
                    Container(
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
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
      ),
    );
  }
}

class LoadingOverlayPopScope extends StatefulWidget {
  final Widget child;

  ///If [allowPop] is true, when user pressed back button
  ///LoadingOverlay will be dismiss and screen will be pop like normal
  final bool allowPop;

  ///Wrap this above your widget to prevent user from pop with screen LoadingOverlayProvider is loading
  ///This only happen in Android since iOS device doesn't have back button
  const LoadingOverlayPopScope({
    Key? key,
    required this.child,
    this.allowPop = false,
  }) : super(key: key);

  @override
  State<LoadingOverlayPopScope> createState() => _LoadingOverlayPopScopeState();
}

class _LoadingOverlayPopScopeState extends State<LoadingOverlayPopScope> {
  void onDismissIfAllow() {
    if (widget.allowPop) {
      LoadingOverlayProvider.toggle(false);
    }
  }

  @override
  void dispose() {
    Future.microtask(() => onDismissIfAllow());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: widget.child,
      onWillPop: () async {
        final bool isLoading = LoadingOverlayProvider.of(context)!.isLoading;
        if (!isLoading) return true;
        return widget.allowPop ? true : !isLoading;
      },
    );
  }
}
