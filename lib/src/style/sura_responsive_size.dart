import 'package:flutter/material.dart';

class SuraResponsiveBreakpoint {
  final double smallPhone;
  final double phone;
  final double tablet;
  final double desktop;

  SuraResponsiveBreakpoint({
    required this.smallPhone,
    required this.phone,
    required this.tablet,
    required this.desktop,
  });

  SuraResponsiveBreakpoint.defaultValue()
      : smallPhone = 320,
        phone = 480,
        tablet = 768,
        desktop = 1024;
}

class SuraResponsive {
  static Size? _size;
  static BuildContext? context;

  static SuraResponsiveBreakpoint _breakPoint =
      SuraResponsiveBreakpoint.defaultValue();

  @protected
  static void init(BuildContext ctx) {
    context = ctx;
    _size = MediaQuery.of(ctx).size;
  }

  @protected
  static void changeBreakpoint(SuraResponsiveBreakpoint breakPoint) {
    _breakPoint = breakPoint;
  }

  ///Define a value depend on Screen width
  ///Will use [phone] value if other value is null
  static double value(
    double phone, [
    double? tablet,
    double? desktop,
    double? smallPhone,
  ]) {
    double screenWidth = _size?.width ?? _breakPoint.phone;
    double? value;
    if (screenWidth >= _breakPoint.desktop) {
      value = desktop;
    } else if (screenWidth >= _breakPoint.tablet) {
      value = tablet;
    } else if (screenWidth <= _breakPoint.smallPhone) {
      value = smallPhone;
    }
    return value ?? phone;
  }
}

class SuraResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  final SuraResponsiveBreakpoint? breakPoint;
  const SuraResponsiveBuilder({
    Key? key,
    required this.builder,
    this.breakPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuraResponsive.init(context);
    if (breakPoint != null) {
      SuraResponsive.changeBreakpoint(breakPoint!);
    }
    return builder(context);
  }
}
