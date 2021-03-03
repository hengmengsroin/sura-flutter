import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Provide a widget child depend on the Platform, Currently support [iOS] and [Android]
class SuraPlatformChecker extends StatelessWidget {
  final Widget androidWidget;
  final Widget iosWidget;
  final Widget webWidget;
  const SuraPlatformChecker({
    Key key,
    @required this.androidWidget,
    this.iosWidget,
    this.webWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPlatformChecker();
  }

  Widget buildPlatformChecker() {
    if (Platform.isIOS && iosWidget != null) {
      return iosWidget;
    } else if (kIsWeb && webWidget != null) {
      return webWidget;
    }
    return androidWidget;
  }
}
