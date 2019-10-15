import 'package:collision_check/src/other/ccoffset.dart';
import 'package:flutter/widgets.dart';

abstract class CcShape {
  CcOffset _position;

  CcShape(CcOffset position) : _position = position ?? CcOffset.zero;

  @mustCallSuper
  // ignore: unnecessary_getters_setters
  set position(CcOffset value) {
    _position = value;
  }

  // ignore: unnecessary_getters_setters
  CcOffset get position => _position;
}
