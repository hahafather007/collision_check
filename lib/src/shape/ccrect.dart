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
  CcRect(this.width, this.height, {CcOffset position = CcOffset.zero})
      : this.left = position.dx,
        this.top = position.dy,
        this.right = position.dx + width,
        this.bottom = position.dy + height,
        this.leftTop = position,
        this.rightTop = position.translate(width, 0),
        this.rightBottom = position.translate(width, height),
        this.leftBottom = position.translate(0, height),
        super(position);

  @override
  set position(CcOffset value) {
    super.position = value;

    left = value.dx;
    top = value.dy;
    right = value.dx + width;
    bottom = value.dy + height;
    leftTop = value;
    rightTop = value.translate(width, 0);
    rightBottom = value.translate(width, height);
    leftBottom = value.translate(0, height);
  }
}
