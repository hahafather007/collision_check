import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CcRect extends CcShape {
  final double height;
  final double width;
  double left;
  double top;
  double right;
  double bottom;
  CcOffset leftTop;
  CcOffset rightTop;
  CcOffset rightBottom;
  CcOffset leftBottom;

  /// 左上角坐标和宽高
  CcRect(this.width, this.height, {CcOffset position})
      : this.left = position?.dx ?? 0,
        this.top = position?.dy ?? 0,
        this.right = position == null ? width : width + position.dx,
        this.bottom = position == null ? height : height + position.dy,
        this.leftTop = position ?? CcOffset.zero,
        this.rightTop = position == null
            ? CcOffset(width, 0)
            : position.translate(width, 0),
        this.rightBottom = position == null
            ? CcOffset(width, height)
            : position.translate(width, height),
        this.leftBottom = position == null
            ? CcOffset(0, height)
            : position.translate(0, height),
        super(position);

  @override
  set position(CcOffset value) {
    super.position = value;

    left = position.dx;
    top = position.dy;
    right = width + position.dx;
    bottom = height + position.dy;
    leftTop = position;
    rightTop += position;
    rightBottom += position;
    leftBottom += position;
  }
}
