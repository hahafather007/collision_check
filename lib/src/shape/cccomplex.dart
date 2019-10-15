import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

/// 复杂几何图形
/// [points] 顺时针开始的所有关键相对于该几何图形外切矩形左上角(0,0)的偏移量
/// [points] 尽可能排除非关键坐标，越少效率越高
class CcComplex extends CcShape {
  final List<CcOffset> points;
  final CcRect rect;

  CcComplex(this.points, {CcOffset position})
      : assert(points.length > 2),
        this.rect = _initRect(points, position),
        super(position) {
    if (position != null) {}
  }

  static CcRect _initRect(List<CcOffset> points, CcOffset position) {
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

    return CcRect(width, height, position: position);
  }

  @override
  set position(CcOffset value) {
    super.position = value;

    points.forEach((offset) => offset.changeValue(value.dx, value.dy));
    rect.position = value;
  }
}
