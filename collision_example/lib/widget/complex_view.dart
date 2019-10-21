import 'package:collision_check/collision_check.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class ComplexView extends BaseView {
  final Color color;
  final CcOffset initPosition;
  final _state = _ComplexState();

  ComplexView(
      {@required this.color, this.initPosition = const CcOffset(100, 100)});

  @override
  BaseState<StatefulWidget> get state => _state;
}

class _ComplexState extends BaseState<ComplexView> {
  CcComplex _shape;

  @override
  void initState() {
    super.initState();

    _shape = CcComplex([
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
    ], position: widget.initPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _shape.position.dx,
      top: _shape.position.dy,
      child: CustomPaint(
        painter: _FiveStar(_shape.relativePoints, widget.color),
        size: Size(_shape.rect.width, _shape.rect.height),
      ),
    );
  }

  @override
  CcShape getShape() {
    return _shape;
  }

  @override
  void move(CcOffset offset) {
    _shape.position += offset;
    setState(() {});
  }
}

/// Demo为五角星控件
/// 可使用图片代替，并在PhotoShop中查看关键段坐标即可
class _FiveStar extends CustomPainter {
  final List<CcOffset> points;
  final Color color;

  _FiveStar(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.lineTo(points.first.dx, points.first.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
