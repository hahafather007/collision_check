import 'dart:ui';

import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CcCircle extends CcShape {
  final Offset center;
  final double radius;
  final CcRect rect;

  CcCircle(this.center, this.radius)
      : this.rect = CcRect.formLTWH(
            center.dx - radius, center.dy - radius, radius * 2, radius * 2);
}
