import 'package:collision_check/src/other/offset.dart';
import 'package:collision_check/src/shape/rect.dart';
import 'package:collision_check/src/shape/shape.dart';

class CcCircle extends CcShape {
  final double radius;
  final CcRect rect;
  CcOffset center;

  CcCircle(this.radius, {CcOffset position = CcOffset.zero})
      : this.center = position.translate(radius, radius),
        this.rect = CcRect(2 * radius, 2 * radius, position: position),
        super(position);

  @override
  set position(CcOffset value) {
    super.position = value;

    rect.position = value;
    center = value.translate(radius, radius);
  }
}
