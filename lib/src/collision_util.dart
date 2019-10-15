import 'dart:math';

import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/cccircle.dart';
import 'package:collision_check/src/shape/cccomplex.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:collision_check/src/shape/ccshape.dart';

class CollisionUtil {
  /// 判断[a]和[b]是否🍌
  static bool isCollision(CcShape a, CcShape b) {
    if (a is CcRect) {
      if (b is CcRect) {
        return _rectToRect(a, b);
      } else if (b is CcCircle) {
        return _rectToCircle(a, b);
      } else {}
    } else if (a is CcCircle) {
      if (b is CcRect) {
        return _rectToCircle(b, a);
      } else if (b is CcCircle) {
        return _circleToCircle(a, b);
      } else {
        return _circleToComplex(a, b);
      }
    } else {
      if (b is CcRect) {
      } else if (b is CcCircle) {
        return _circleToComplex(b, a);
      } else {}
    }

    return false;
  }

  /// 矩形与矩形
  static bool _rectToRect(CcRect a, CcRect b) {
    if (a.right < b.left || b.right < a.left) return false;
    if (a.bottom < b.top || b.bottom < a.top) return false;

    return true;
  }

  /// 矩形与圆形
  static bool _rectToCircle(CcRect a, CcCircle b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!_rectToRect(a, b.rect)) return false;

    final points = [
      a.leftTop,
      a.rightTop,
      a.rightBottom,
      a.leftBottom,
      a.leftTop,
    ];
    for (var i = 0; i < points.length - 1; i++) {
      final distance = _getNearestDistance(points[i], points[i + 1], b.center);
      if (_getFixDouble(distance) <= b.radius) return true;
    }

    return false;
  }

  /// 圆形与圆形
  static bool _circleToCircle(CcCircle a, CcCircle b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!_rectToRect(a.rect, b.rect)) return false;

    final distance = a.radius + b.radius;
    final w = a.center.dx - b.center.dx;
    final h = a.center.dy - b.center.dy;

    return sqrt(w * w + h * h) <= distance;
  }

  /// 圆形与复杂图形
  static bool _circleToComplex(CcCircle a, CcComplex b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!_rectToRect(a.rect, b.rect)) return false;

    final points = b.points.toList();
    points.add(points.first);
    for (var i = 0; i < points.length - 1; i++) {
      final distance = _getNearestDistance(points[i], points[i + 1], a.center);
      if (distance <= a.radius) {
        return true;
      }
    }

    return false;
  }

  /// 获取[o]点距离[o1]和[o2]线段的距离
  /// https://blog.csdn.net/yjukh/article/details/5213577
  static double _getNearestDistance(CcOffset o1, CcOffset o2, CcOffset o) {
    // 判断该点是否为线段端点
    if (o1 == o || o2 == o) return 0;

    final a = o2.distance(o);
    final b = o1.distance(o);
    final c = o1.distance(o2);

    // 判断是否为钝角
    if (a * a >= b * b + c * c) return b;
    if (b * b >= a * a + c * c) return a;

    // 海伦公式
    final l = (a + b + c) / 2;
    final area = sqrt(l * (l - a) * (l - b) * (l - c));

    return 2 * area / c;
  }

  /// 获取保留4位小数的[double]值，避免精度问题带来的误差
  static double _getFixDouble(double value) {
    return double.parse(value.toStringAsFixed(4));
  }
}
