import 'package:flutter/material.dart';

class SuraResponsive {
  static Size? _size;
  static BuildContext? context;

  static void init(BuildContext ctx) {
    context = ctx;
    _size = MediaQuery.of(ctx).size;
  }

  static double value(double phone,
      [double? laptop, double? tablet, double? smallPhone]) {
    double width = _size?.width ?? 480;
    if (width >= 1024) {
      return laptop ?? phone;
    } else if (width >= 768) {
      return tablet ?? phone;
    } else if (width <= 350) {
      return smallPhone ?? phone;
    }
    return phone;
  }
}

class SuraResponsiveBuilder extends StatelessWidget {
  final Widget child;
  const SuraResponsiveBuilder({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuraResponsive.init(context);
    return child;
  }
}
