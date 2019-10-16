import 'package:collision_check/src/other/offset.dart';
import 'package:flutter/widgets.dart' show mustCallSuper;

abstract class CcShape {
  CcOffset _position;

  CcShape(CcOffset position)
      : assert(position != null),
        _position = position;

  @mustCallSuper
  // ignore: unnecessary_getters_setters
  set position(CcOffset value) {
    _position = value;
  }

  // ignore: unnecessary_getters_setters
  CcOffset get position => _position;
}