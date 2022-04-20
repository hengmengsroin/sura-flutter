import 'package:flutter/material.dart';

enum SuraResponsiveRule {
  multiply,
  add,
}

enum SuraResponsiveBreakpointName {
  mobileSmall,
  mobile,
  tablet,
  desktop,
}

class SuraResponsiveBreakpoint {
  final double mobileSmall;
  final double mobile;
  final double tablet;
  final double desktop;

  SuraResponsiveBreakpoint({
    required this.mobileSmall,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  SuraResponsiveBreakpoint.defaultValue()
      : mobileSmall = 320,
        mobile = 480,
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

  static SuraResponsiveBreakpointName _getBreakpointName() {
    double screenWidth = _size?.width ?? _breakPoint.mobile;
    if (screenWidth >= _breakPoint.desktop) {
      return SuraResponsiveBreakpointName.desktop;
    } else if (screenWidth >= _breakPoint.tablet) {
      return SuraResponsiveBreakpointName.tablet;
    } else if (screenWidth <= _breakPoint.mobileSmall) {
      return SuraResponsiveBreakpointName.mobileSmall;
    }
    return SuraResponsiveBreakpointName.mobile;
  }

  ///Define a value depend on Screen width
  ///Will use [mobile] value if other value is null
  ///Auto calculate for desktop if tablet isn't null
  static double value(
    double mobile, [
    double? tablet,
    double? desktop,
    double? mobileSmall,
  ]) {
    double? value;
    SuraResponsiveBreakpointName breakpointName = _getBreakpointName();
    switch (breakpointName) {
      case SuraResponsiveBreakpointName.mobileSmall:
        value = mobileSmall;
        break;
      case SuraResponsiveBreakpointName.mobile:
        value = mobile;
        break;
      case SuraResponsiveBreakpointName.tablet:
        value = tablet;
        break;
      case SuraResponsiveBreakpointName.desktop:

        ///Calculate the value for desktop if it's null and tablet isn't null
        double? defaultForDesktop;
        if (desktop == null && tablet != null) {
          defaultForDesktop = tablet + (tablet - mobile);
        }
        value = desktop ?? defaultForDesktop;
        break;
    }
    return value ?? mobile;
  }

  ///Define a responsive value base on defined rule
  ///Best use case for spacing and container
  static double auto(double mobile,
      [SuraResponsiveRule rule = SuraResponsiveRule.add]) {
    double value = mobile;
    SuraResponsiveBreakpointName breakpointName = _getBreakpointName();
    bool isMultiply = rule == SuraResponsiveRule.multiply;
    switch (breakpointName) {
      case SuraResponsiveBreakpointName.mobileSmall:
        value = isMultiply ? value - (value * 0.25) : value - 4;
        break;
      case SuraResponsiveBreakpointName.mobile:
        value = mobile;
        break;
      case SuraResponsiveBreakpointName.tablet:
        value = isMultiply ? value * 2 : value + 8;
        break;
      case SuraResponsiveBreakpointName.desktop:
        value = isMultiply ? value * 3 : value + 16;
        break;
    }
    return value;
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
