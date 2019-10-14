import 'package:collision_check/src/shape/cccircle.dart';
import 'package:collision_check/src/shape/ccrect.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collision_check/collision_check.dart';

void main() {
  final value1 = CollisionUtil.isCollision(
      CcRect.formLTRB(0, 0, 2, 2), CcCircle(Offset(2, 3), 3));
  assert(value1 == true);

  final value2 = CollisionUtil.isCollision(
      CcCircle(Offset(2, 2), 1), CcCircle(Offset(2, 4), 1));
  assert(value2 == true);

  final value3 = CollisionUtil.isCollision(
      CcCircle(Offset(2, 2), 1), CcCircle(Offset(3, 4), 1));
  assert(value3 == false);
}
