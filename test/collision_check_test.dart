import 'package:collision_check/src/shape/cccircle.dart';
import 'package:collision_check/src/shape/cccomplex.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collision_check/collision_check.dart';

void main() {
  test("碰撞测试", () {
    final value1 = CollisionUtil.isCollision(
        CcRect(2, 2), CcCircle(3, center: Offset(2, 3)));
    assert(value1 == true);

    final value2 = CollisionUtil.isCollision(
        CcCircle(1, center: Offset(2, 2)), CcCircle(1, center: Offset(2, 4)));
    assert(value2 == true);

    final value3 = CollisionUtil.isCollision(
        CcCircle(1, center: Offset(2, 2)), CcCircle(1, center: Offset(3, 4)));
    assert(value3 == false);

    final value4 = CollisionUtil.isCollision(
        CcCircle(1, center: Offset(2, 2)), CcCircle(1, center: Offset(2, 3)));
    assert(value4 == true);

    final complex = CcComplex([
      Offset(1, 1),
      Offset(2.8, 1),
      Offset(3, 0),
      Offset(3.2, 1),
      Offset(5, 1),
      Offset(3.5, 2),
      Offset(4, 4),
      Offset(3, 3),
      Offset(2, 4),
      Offset(2.5, 2),
    ]);
    for (var i = 0; i < 99999; i++) {
      complex.setPosition(const Offset(1, 1));
      final value5 = CollisionUtil.isCollision(
          complex, CcCircle(2, center: Offset(1, 1.2)));
//      assert(value5 == true);
    }
  });
}
