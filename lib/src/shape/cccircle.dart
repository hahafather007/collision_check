import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CcCircle extends CcShape {
  final double radius;
  final CcRect rect;
  CcOffset center;

  CcCircle(this.radius, {CcOffset center, CcOffset position})
      : assert(center == null || position == null),
        this.center = center == null
            ? position == null
                ? CcOffset(radius, radius)
                : position.translate(radius, radius)
            : center,
        this.rect = CcRect(radius * 2, radius * 2,
            position: center == null
                ? position == null ? CcOffset.zero : position
                : center.translate(-radius, -radius)),
        super(center == null ? position : center.translate(-radius, -radius));

  @override
  set position(CcOffset value) {
    super.position = value;

    rect.position = value;
    center += value;
  }
}
