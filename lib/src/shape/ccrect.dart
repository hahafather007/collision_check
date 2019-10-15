import 'package:collision_check/src/shape/ccshape.dart';
import 'package:flutter/cupertino.dart';

class CcRect extends CcShape {
  final double height;
  final double width;
  double left;
  double top;
  double right;
  double bottom;
  Offset leftTop;
  Offset rightTop;
  Offset rightBottom;
  Offset leftBottom;

  /// 左上角坐标和宽高
  CcRect(this.width, this.height, {Offset position = const Offset(0, 0)})
      : left = 0,
        top = 0,
        right = width,
        bottom = height,
        this.leftTop = position,
        this.rightTop = position.translate(width, 0),
        this.rightBottom = position.translate(width, height),
        this.leftBottom = position.translate(0, height);

  @override
  void setPosition(Offset position) {
    leftTop = position;
    rightTop += position;
    rightBottom += position;
    leftBottom += position;
  }
}
