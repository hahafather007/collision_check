import 'package:collision_check/src/other/ccoffset.dart';
import 'package:collision_check/src/shape/cccircle.dart';
import 'package:collision_check/src/shape/cccomplex.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collision_check/collision_check.dart';

void main() {
  test("碰撞测试", () {
    final value1 = CollisionUtil.isCollision(
        CcRect(2, 2), CcCircle(3, center: CcOffset(2, 3)));
    assert(value1 == true);

    final value2 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(2, 4)));
    assert(value2 == true);

    final value3 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(3, 4)));
    assert(value3 == false);

    final value4 = CollisionUtil.isCollision(
        CcCircle(1, center: CcOffset(2, 2)),
        CcCircle(1, center: CcOffset(2, 3)));
    assert(value4 == true);

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
    for (var i = 0; i < 99999; i++) {
      complex.position = CcOffset(1, 1);
      final value5 = CollisionUtil.isCollision(
          complex, CcCircle(2, center: CcOffset(1, 1.2)));
//      assert(value5 == true);
    }
  });
}
