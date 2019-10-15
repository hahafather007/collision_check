import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CcCircle extends CcShape {
  final double radius;
  final CcRect rect;
  CcOffset center;

  CcCircle(this.radius, {CcOffset center, CcOffset position})
      : assert(center == null || position == null),
        this.center = center ??
            (position == null
                ? CcOffset.zero.translate(radius, radius)
                : position.translate(radius, radius)),
        this.rect =
            CcRect(2 * radius, 2 * radius, position: position ?? CcOffset.zero),
        super(position ?? CcOffset.zero);

  @override
  set position(CcOffset value) {
    super.position = value;

    rect.position = value;
    value.translate(radius, radius);
  }
}
