import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LeftInputBorder extends UnderlineInputBorder {
  const LeftInputBorder({
    BorderSide borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  })  : assert(borderRadius != null),
        super(borderSide: borderSide);

  final BorderRadius borderRadius;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    ui.TextDirection textDirection,
  }) {
    if (borderRadius.bottomLeft != Radius.zero ||
        borderRadius.bottomRight != Radius.zero)
      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    canvas.drawLine(rect.topLeft, rect.bottomLeft, borderSide.toPaint());
  }
}

LeftInputBorder leftPrimaryBorder(BuildContext context, double width) =>
    LeftInputBorder(
      borderRadius: BorderRadius.all(Radius.zero),
      borderSide:
          BorderSide(color: Theme.of(context).primaryColor, width: width),
    );
