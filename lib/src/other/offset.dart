import 'dart:math' show sqrt;
import 'dart:ui' show Offset;

class CcOffset {
  final double dx;
  final double dy;

  const CcOffset(this.dx, this.dy);

  CcOffset.formOffset(Offset offset)
      : assert(Offset != null),
        this.dx = offset.dx,
        this.dy = offset.dy;

  CcOffset translate(double translateX, double translateY) =>
      CcOffset(dx + translateX, dy + translateY);

  double distance(CcOffset other) {
    final w = dx - other.dx;
    final h = dy - other.dy;

    return sqrt(w * w + h * h);
  }

  static const CcOffset zero = const CcOffset(0, 0);

  CcOffset operator +(CcOffset other) => CcOffset(dx + other.dx, dy + other.dy);

  CcOffset operator -(CcOffset other) => CcOffset(dx - other.dx, dy - other.dy);

  @override
  bool operator ==(dynamic other) {
    assert(other is CcOffset);

    return dx == other.dx && dy == other.dy;
  }

  @override
  int get hashCode => dx.hashCode + dy.hashCode + dx ~/ dy;
}
