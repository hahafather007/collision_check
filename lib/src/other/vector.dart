import 'package:collision_check/src/other/offset.dart';

/// 向量
class CcVector {
  final CcOffset start;
  final CcOffset end;
  final double x;
  final double y;

  CcVector(this.start, this.end)
      : x = end.dx - start.dx,
        y = end.dy - start.dy;
}
