import 'dart:ui';

import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

/// 复杂几何图形
/// [points] 顺时针开始的所有关键相对于该几何图形外切矩形左上角(0,0)的偏移量
/// [points] 尽可能排除非关键坐标，越少效率越高
class CcComplex extends CcShape {
  final List<Offset> points;
  final CcRect rect;

  CcComplex(this.points, {Offset position = const Offset(0, 0)})
      : assert(points.length > 2),
        this.rect = _initRect(points) {
    if (position != const Offset(0, 0)) {
      setPosition(position);
    }
  }

  static CcRect _initRect(List<Offset> points) {
    double height = 0;
    double width = 0;
    points.forEach((offset) {
      if (offset.dx > width) {
        width = offset.dx;
      }
      if (offset.dy > height) {
        height = offset.dy;
      }
    });

    return CcRect(width, height);
  }

  @override
  void setPosition(Offset position) {
    for (var i = 0; i < points.length; i++) {
      points[i] += position;
    }
    rect.setPosition(position);
  }
}
