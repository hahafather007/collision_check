import 'package:collision_check/src/other/offset.dart';
import 'package:collision_check/src/shape/circle.dart';
import 'package:collision_check/src/shape/complex.dart';
import 'package:collision_check/src/shape/rect.dart';
import 'package:collision_check/collision_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("碰撞测试", () {
    // 矩形与圆形
    final value1 = CollisionUtil.isCollision(
        CcRect(2, 2), CcCircle(3, center: CcOffset(2, 3)));
    assert(value1 == true);

    // 圆形与圆形
    final value2 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(2, 4)));
    assert(value2 == true);

    // 圆形与圆形
    final value3 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(3, 4)));
    assert(value3 == false);

    // 圆形与圆形
    final value4 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(2, 3)));
    assert(value4 == true);

    // 复杂几何图形（下面是一个⭐️）与圆形
    final complex = CcComplex([
      CcOffset(1, 1),
      CcOffset(2.8, 1),
      CcOffset(3, 0),
      CcOffset(3.2, 1),
      CcOffset(5, 1),
      CcOffset(3.5, 2),
      CcOffset(4, 4),
      CcOffset(3, 3),
      CcOffset(2, 4),
      CcOffset(2.5, 2),
    ]);
    for (var i = 0; i < 1000000; i++) {
      complex.position = CcOffset(1, 1);
      final value5 = CollisionUtil.isCollision(
          complex, CcCircle(2, center: CcOffset(1, 1.2)));
      assert(value5 == true);
    }
  });
}
