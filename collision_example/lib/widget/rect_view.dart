import 'package:collision_check/collision_check.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class RectView extends BaseView {
  final Color color;
  final CcOffset initPosition;
  final _state = _RectState();

  RectView(
      {@required this.color, this.initPosition = const CcOffset(100, 100)});

  @override
  BaseState<StatefulWidget> get state => _state;
}

class _RectState extends BaseState<RectView> {
  CcRect _shape;

  @override
  void initState() {
    super.initState();

    _shape = CcRect(40, 40, position: widget.initPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _shape.position.dx,
      top: _shape.position.dy,
      child: Container(
        width: _shape.width,
        height: _shape.height,
        color: widget.color,
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
