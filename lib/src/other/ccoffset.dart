import 'dart:math';

class CcOffset {
  double _dx;
  double _dy;

  double get dx => _dx;

  double get dy => _dy;

  CcOffset(double dx, double dy)
      : this._dx = dx,
        this._dy = dy;

  CcOffset translate(double translateX, double translateY) =>
      CcOffset(dx + translateX, dy + translateY);

  void changeValue(double valueX, double valueY) {
    _dx += valueX;
    _dy += valueY;
  }

  double distance(CcOffset other){
    final w = dx - other.dx;
    final h = dy - other.dy;

    return sqrt(w * w + h * h);
  }

  static CcOffset get zero => CcOffset(0, 0);

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
