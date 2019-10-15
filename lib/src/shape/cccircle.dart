import 'dart:ui';

import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CcCircle extends CcShape {
  final double radius;
  final CcRect rect;
  Offset center;

  CcCircle(this.radius, {Offset center})
      : this.center = center == null ? Offset(radius, radius) : center,
        this.rect = CcRect(radius * 2, radius * 2,
            position: center == null
                ? const Offset(0, 0)
                : center.translate(-radius, -radius));

  @override
  void setPosition(Offset position) {
    center += position;
    rect.setPosition(position);
  }
}
