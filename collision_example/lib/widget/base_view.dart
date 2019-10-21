import 'package:collision_check/collision_check.dart';
import 'package:flutter/material.dart';

abstract class BaseView extends StatefulWidget {
  BaseState get state;

  BaseView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  void move(CcOffset offset) {
    state.move(offset);
  }

  CcShape getShape() {
    return state.getShape();
  }
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  void move(CcOffset offset);

  CcShape getShape();
}
