import 'package:flutter/material.dart';
import 'package:sura_flutter/src/widgets/spacing.dart';
import 'package:universal_platform/universal_platform.dart';

///Provide a widget child depend on the Platform, Currently support [iOS] and [Android]
class SuraPlatformChecker extends StatelessWidget {
  final Widget androidWidget;
  final Widget? iosWidget;
  final Widget? webWidget;
  const SuraPlatformChecker({
    Key? key,
    required this.androidWidget,
    this.iosWidget,
    this.webWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPlatformChecker();
  }

  Widget buildPlatformChecker() {
    if (UniversalPlatform.isIOS && iosWidget != null) {
      return iosWidget ?? emptySizedBox;
    } else if (UniversalPlatform.isWeb && webWidget != null) {
      return webWidget ?? emptySizedBox;
    }
    return androidWidget;
  }
}
