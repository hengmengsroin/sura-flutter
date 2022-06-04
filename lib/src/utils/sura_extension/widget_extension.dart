import 'package:flutter/material.dart';

import '../../../sura_flutter.dart';

extension SuraWidgetExtension on Widget {
  Widget padding([EdgeInsets padding = const EdgeInsets.all(8)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  ///add padding all to a widget
  Widget paddingValue({
    double? all,
    double? vertical,
    double? horizontal,
  }) {
    if (all != null && (vertical != null || horizontal != null)) {
      throw FlutterError(
        "paddingValue Error: Can't provide both all and horizontal or vertical at the same time",
      );
    }
    EdgeInsets padding;
    if (horizontal != null || vertical != null) {
      padding = EdgeInsets.symmetric(
        vertical: vertical ?? 0.0,
        horizontal: horizontal ?? 0.0,
      );
    } else {
      padding = EdgeInsets.all(all ?? 0.0);
    }

    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget margin([EdgeInsets margin = const EdgeInsets.all(8)]) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  Widget marginValue({
    double? all,
    double? vertical,
    double? horizontal,
  }) {
    if (all != null && (vertical != null || horizontal != null)) {
      throw FlutterError(
        "marginValue Error: Can't provide both all and horizontal or vertical at the same time",
      );
    }
    EdgeInsets margin;
    if (horizontal != null || vertical != null) {
      margin = EdgeInsets.symmetric(
        vertical: vertical ?? 0.0,
        horizontal: horizontal ?? 0.0,
      );
    } else {
      margin = EdgeInsets.all(all ?? 0.0);
    }

    return Container(
      margin: margin,
      child: this,
    );
  }

  Widget cssSpacing({
    List<double> margin = const [],
    List<double> padding = const [],
  }) {
    EdgeInsets defineMargin = EdgeInsets.zero;
    EdgeInsets definePadding = EdgeInsets.zero;

    if (margin.isNotEmpty) {
      switch (margin.length) {
        case 1:
          defineMargin = EdgeInsets.all(margin.elementAt(0));
          break;
        case 2:
          defineMargin = EdgeInsets.symmetric(
              vertical: margin.elementAt(0), horizontal: margin.elementAt(1));
          break;

        case 3:
          defineMargin = EdgeInsets.only(
              top: margin.elementAt(0),
              right: margin.elementAt(1),
              bottom: margin.elementAt(2));
          break;

        default:
          defineMargin = EdgeInsets.only(
              top: margin.elementAt(0),
              right: margin.elementAt(1),
              bottom: margin.elementAt(2),
              left: margin.elementAt(3));
          break;
      }
    }

    if (padding.isNotEmpty) {
      switch (padding.length) {
        case 1:
          definePadding = EdgeInsets.all(padding.elementAt(0));
          break;
        case 2:
          definePadding = EdgeInsets.symmetric(
              vertical: padding.elementAt(0), horizontal: padding.elementAt(1));
          break;

        case 3:
          definePadding = EdgeInsets.only(
              top: padding.elementAt(0),
              right: padding.elementAt(1),
              bottom: padding.elementAt(2));
          break;

        default:
          definePadding = EdgeInsets.only(
              top: padding.elementAt(0),
              right: padding.elementAt(1),
              bottom: padding.elementAt(2),
              left: padding.elementAt(3));
          break;
      }
    }

    return Container(
      padding: definePadding,
      margin: defineMargin,
      child: this,
    );
  }

  ///Rotate a widget in Degreee
  Widget rotate([double degree = 0]) {
    return Transform.rotate(
      angle: SuraUtils.degreeToRadian(degree),
      child: this,
    );
  }

  Widget opacity([double opacity = 1]) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget textColor([Color color = Colors.white]) {
    if (this is Text) {
      return DefaultTextStyle.merge(
        style: TextStyle(color: color),
        child: this,
      );
    }
    return this;
  }

  Widget applyStyle({
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14,
  }) {
    if (this is Text) {
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
        child: this,
      );
    }
    return this;
  }

  Widget get expanded => Expanded(child: this);

  Widget get flexible => Flexible(child: this);

  Widget get ovalClip => ClipOval(child: this);
}
