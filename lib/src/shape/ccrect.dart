import 'package:collision_check/src/shape/ccshape.dart';
import 'package:flutter/cupertino.dart';

class CcRect extends CcShape {
  final double height;
  final double width;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final Offset leftTop;
  final Offset rightTop;
  final Offset rightBottom;
  final Offset leftBottom;

  /// 左上角坐标和宽高
  CcRect.formLTWH(this.left, this.top, this.width, this.height)
      : this.right = left + width,
        this.bottom = top + height,
        this.leftTop = Offset(left, top),
        this.rightTop = Offset(left + width, top),
        this.rightBottom = Offset(left + width, top + height),
        this.leftBottom = Offset(left, top - height);

  /// 左上角坐标和右下角坐标
  CcRect.formLTRB(this.left, this.top, this.right, this.bottom)
      : this.width = right - left,
        this.height = bottom - top,
        this.leftTop = Offset(left, top),
        this.rightTop = Offset(right, top),
        this.rightBottom = Offset(right, bottom),
        this.leftBottom = Offset(left, bottom);
}
