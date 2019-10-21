import 'dart:math';

import 'package:collision_check/src/other/offset.dart';
import 'package:collision_check/src/other/vector.dart';
import 'package:collision_check/src/shape/circle.dart';
import 'package:collision_check/src/shape/complex.dart';
import 'package:collision_check/src/shape/rect.dart';
import 'package:collision_check/src/shape/shape.dart';

class CollisionUtil {
  /// 判断[a]和[b]是否🍌
  static bool isCollision(CcShape a, CcShape b) {
    if (a is CcRect) {
      if (b is CcRect) {
        return rectToRect(a, b);
      } else if (b is CcCircle) {
        return rectToCircle(a, b);
      } else {
        return rectToComplex(a, b);
      }
    } else if (a is CcCircle) {
      if (b is CcRect) {
        return rectToCircle(b, a);
      } else if (b is CcCircle) {
        return circleToCircle(a, b);
      } else {
        return circleToComplex(a, b);
      }
    } else {
      if (b is CcRect) {
        return rectToComplex(b, a);
      } else if (b is CcCircle) {
        return circleToComplex(b, a);
      } else {
        return complexToComplex(a, b);
      }
    }
  }

  /// 矩形与矩形
  static bool rectToRect(CcRect a, CcRect b) {
    if (a.right < b.left || b.right < a.left) return false;
    if (a.bottom < b.top || b.bottom < a.top) return false;

    return true;
  }

  /// 矩形与圆形
  static bool rectToCircle(CcRect a, CcCircle b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!rectToRect(a, b.rect)) return false;

    final points = [
      a.leftTop,
      a.rightTop,
      a.rightBottom,
      a.leftBottom,
      a.leftTop,
    ];
    for (var i = 0; i < points.length - 1; i++) {
      final distance = getNearestDistance(points[i], points[i + 1], b.center);
      if (_getFixDouble(distance) <= b.radius) return true;
    }

    return false;
  }

  /// 矩形与复杂图形
  static bool rectToComplex(CcRect a, CcComplex b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!rectToRect(a, b.rect)) return false;
    if (!isLinesShadowOver(
        a.leftTop, a.rightBottom, b.rect.leftTop, b.rect.rightBottom))
      return false;

    final pointsA = [
      a.leftTop,
      a.rightTop,
      a.rightBottom,
      a.leftBottom,
      a.leftTop,
    ];
    final pointsB = b.points.toList()..add(b.points.first);

    for (var i = 0; i < pointsA.length - 1; i++) {
      final pointA = pointsA[i];
      final pointB = pointsA[i + 1];
      for (var j = 0; j < pointsB.length - 1; j++) {
        final pointC = pointsB[j];
        final pointD = pointsB[j + 1];
        // 同理排除不可能🍌的情况
        if (!isLinesShadowOver(pointA, pointB, pointC, pointD)) {
          continue;
        }

        if (isLinesOver(pointA, pointB, pointC, pointD)) {
          return true;
        }
      }
    }

    return false;
  }

  /// 圆形与圆形
  static bool circleToCircle(CcCircle a, CcCircle b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!rectToRect(a.rect, b.rect)) return false;

    final distance = a.radius + b.radius;
    final w = a.center.dx - b.center.dx;
    final h = a.center.dy - b.center.dy;

    return sqrt(w * w + h * h) <= distance;
  }

  /// 复杂图形与复杂图形
  static bool complexToComplex(CcComplex a, CcComplex b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!rectToRect(a.rect, b.rect)) return false;

    final pointsA = a.points.toList()..add(a.points.first);
    final pointsB = b.points.toList()..add(b.points.first);
    for (var i = 0; i < pointsA.length - 1; i++) {
      final pointA = pointsA[i];
      final pointB = pointsA[i + 1];
      // 排除不可能🍌的情况
      if (!isLinesShadowOver(
          pointA, pointB, b.rect.leftTop, b.rect.rightBottom)) {
        continue;
      }

      for (var j = 0; j < pointsB.length - 1; j++) {
        final pointC = pointsB[j];
        final pointD = pointsB[j + 1];
        // 同理排除不可能🍌的情况
        if (!isLinesShadowOver(pointA, pointB, pointC, pointD)) {
          continue;
        }

        if (isLinesOver(pointA, pointB, pointC, pointD)) {
          return true;
        }
      }
    }

    return false;
  }

  /// 圆形与复杂图形
  static bool circleToComplex(CcCircle a, CcComplex b) {
    // 优先利用外切矩形进行计算，节约开销
    if (!rectToRect(a.rect, b.rect)) return false;

    final points = b.points.toList();
    points.add(points.first);
    for (var i = 0; i < points.length - 1; i++) {
      final distance = getNearestDistance(points[i], points[i + 1], a.center);
      if (distance <= a.radius) {
        return true;
      }
    }

    return false;
  }

  /// 获取[o]点距离[o1]和[o2]线段的距离
  /// https://blog.csdn.net/yjukh/article/details/5213577
  static double getNearestDistance(CcOffset o1, CcOffset o2, CcOffset o) {
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

  /// 快速排斥实验
  /// 判断[a]~[b]线段与[c]~[d]线段在x轴和y轴上的投影是否有公共区域
  static bool isLinesShadowOver(
      CcOffset a, CcOffset b, CcOffset c, CcOffset d) {
    if (min(a.dx, b.dx) > max(c.dx, d.dx) ||
        min(c.dx, d.dx) > max(a.dx, b.dx) ||
        min(a.dy, b.dy) > max(c.dy, d.dy) ||
        min(c.dy, d.dy) > max(a.dy, b.dy)) {
      return false;
    }

    return true;
  }

  /// 跨立实验
  /// 判断[a]~[b]线段与[c]~[d]线段是否🍌
  /// https://www.rogoso.info/%E5%88%A4%E6%96%AD%E7%BA%BF%E6%AE%B5%E7%9B%B8%E4%BA%A4/
  static bool isLinesOver(CcOffset a, CcOffset b, CcOffset c, CcOffset d) {
    final ac = CcVector(a, c);
    final ad = CcVector(a, d);
    final bc = CcVector(b, c);
    final bd = CcVector(b, d);
    final ca = ac.negative;
    final cb = bc.negative;
    final da = ad.negative;
    final db = bd.negative;

    return vectorProduct(ac, ad) * vectorProduct(bc, bd) <= 0 &&
        vectorProduct(ca, cb) * vectorProduct(da, db) <= 0;
  }

  /// 计算x1*y2-x2*y1;
  static double vectorProduct(CcVector a, CcVector b) {
    return a.x * b.y - b.x * a.y;
  }
}
