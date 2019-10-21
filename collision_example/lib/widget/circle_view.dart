import 'package:collision_check/collision_check.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class CircleView extends BaseView {
  final Color color;
  final CcOffset initPosition;
  final _state = _CircleState();

  CircleView(
      {@required this.color, this.initPosition = const CcOffset(100, 100)});

  @override
  BaseState<StatefulWidget> get state => _state;
}

class _CircleState extends BaseState<CircleView> {
  CcCircle _shape;

  @override
  void initState() {
    super.initState();

    _shape = CcCircle(20, position: widget.initPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _shape.position.dx,
      top: _shape.position.dy,
      child: Container(
        width: _shape.radius * 2,
        height: _shape.radius * 2,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
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
