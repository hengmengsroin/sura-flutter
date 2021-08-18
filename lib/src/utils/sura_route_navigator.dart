import 'package:flutter/material.dart';

///Less boilerplate MaterialPageRoute builder
class PageNavigator {
  ///short handed push navigator
  static Future push<T>(BuildContext context, Widget page) async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) => page));
  }

  ///short handed push replacement navigator
  static Future pushReplacement(BuildContext context, Widget page) async {
    return await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  ///short handed push and remove navigator
  static Future pushAndRemove(BuildContext context, Widget page) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (dynamic) => false,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }
}

class SuraNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static get getContext => navigatorKey.currentState?.overlay?.context;

  ///pop the current route
  static void pop<T>([T? result]) {
    Navigator.of(getContext).pop(result);
  }

  ///Push the navigator to widget's route
  static Future push<T>(Widget page, {bool fullsreenDialog = false}) async {
    return await Navigator.of(getContext).push<T>(MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullsreenDialog,
    ));
  }

  static Future pushNamed<T>(String name, {Object? argument}) async {
    return await Navigator.of(getContext)
        .pushNamed<T>(name, arguments: argument);
  }

  ///short handed push replacement navigator
  static Future pushReplacement(Widget page,
      {bool fullScreenDialog = false}) async {
    return await Navigator.of(getContext).pushReplacement(MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullScreenDialog,
    ));
  }

  ///short handed push and remove navigator
  static Future pushAndRemove(Widget page) async {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (_) => false,
    );
  }

  ///show a dialog
  static Future<T?> dialog<T>(Widget dialog,
      {bool barrierDismissible = true}) async {
    return await showDialog<T>(
      context: getContext,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }
}
