import 'dart:ui';

import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

/// 复杂几何图形
/// [points] 顺时针开始的所有关键坐标点（尽可能排除非关键坐标，越少效率越高）
class CcComplex extends CcShape {
  final List<Offset> points;
  final CcRect rect;

  CcComplex(this.points)
      : assert(points.length > 2),
        this.rect = _getRect(points);

  static CcRect _getRect(List<Offset> points) {
    final allDx = points.map((v) => v.dx).toList();
    final allDy = points.map((v) => v.dy).toList();
    allDx.sort();
    allDy.sort();

    return CcRect.formLTRB(allDx.first, allDy.first, allDx.last, allDy.last);
  }
}
