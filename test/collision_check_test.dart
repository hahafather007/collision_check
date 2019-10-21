import 'package:collision_check/src/other/offset.dart';
import 'package:collision_check/src/shape/complex.dart';
import 'package:collision_check/collision_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("碰撞测试", () {
    // 复杂几何图形（下面是一个⭐️）
    final complex = CcComplex([
      CcOffset(25, 0),
      CcOffset(31, 18),
      CcOffset(50, 18),
      CcOffset(34, 31),
      CcOffset(40, 50),
      CcOffset(25, 38),
      CcOffset(10, 50),
      CcOffset(14, 31),
      CcOffset(0, 18),
      CcOffset(18, 18),
    ]);

    final complex2 = CcComplex([
      CcOffset(25, 0),
      CcOffset(31, 18),
      CcOffset(50, 18),
      CcOffset(34, 31),
      CcOffset(40, 50),
      CcOffset(25, 38),
      CcOffset(10, 50),
      CcOffset(14, 31),
      CcOffset(0, 18),
      CcOffset(18, 18),
    ]);
    for (var i = 0; i < 1000000; i++) {
      complex.position = CcOffset(1, 1.12312);
      complex2.position = CcOffset(4.12343, 0.2384892349);
      final value6 = CollisionUtil.isCollision(complex, complex2);
      assert(value6 == true);
    }
  });
}
