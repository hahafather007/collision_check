import 'package:collision_check/collision_check.dart';
import 'package:collision_example/widget/base_view.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final BaseView shapeA;
  final BaseView shapeB;

  TestPage({@required this.shapeA, @required this.shapeB});

  @override
  State createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool _isCollision = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (detail) {
          widget.shapeB.move(CcOffset.formOffset(detail.delta));
          // 循环1000次是为了模仿一般游戏中有大量物体需要碰撞检查的情况
          for (var i = 0; i < 1000; i++) {
            CollisionUtil.isCollision(
                widget.shapeA.getShape(), widget.shapeB.getShape());
          }
          final result = CollisionUtil.isCollision(
              widget.shapeA.getShape(), widget.shapeB.getShape());
          if (result != _isCollision) {
            setState(() => _isCollision = result);
          }
        },
        child: Stack(
          children: <Widget>[
            widget.shapeA,
            widget.shapeB,
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(_isCollision ? "相撞！" : "没有相撞"),
            ),
          ],
        ),
      ),
    );
  }
}
