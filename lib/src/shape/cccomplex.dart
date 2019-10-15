import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

/// 复杂几何图形
/// [_relativePoints] 顺时针开始的所有关键相对于该几何图形外切矩形左上角(0,0)的偏移量（尽可能排除非关键坐标，越少效率越高）
class CcComplex extends CcShape {
  final List<CcOffset> relativePoints;
  final List<CcOffset> points;
  final CcRect rect;

  CcComplex(this.relativePoints, {CcOffset position = CcOffset.zero})
      : assert(relativePoints.length > 2),
        this.points = _initPoints(relativePoints, position),
        this.rect = _initRect(relativePoints, position),
        super(position);

  static List<CcOffset> _initPoints(
      List<CcOffset> relativePoints, CcOffset position) {
    final list = List<CcOffset>(relativePoints.length);
    for (var i = 0; i < list.length; i++) {
      list[i] = relativePoints[i] + position;
    }

    return list;
  }

  static CcRect _initRect(List<CcOffset> relativePoints, CcOffset position) {
    double height = 0;
    double width = 0;
    relativePoints.forEach((offset) {
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

    rect.position = value;
    for (var i = 0; i < points.length; i++) {
      points[i] = relativePoints[i] + value;
    }
  }
}
