import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGradient extends BoxDecoration {
  static final FractionalOffset begin = FractionalOffset(0.0, 0.0);
  static final FractionalOffset endHorizotal = FractionalOffset(1.0, 0.0);
  static final FractionalOffset endVertical = FractionalOffset(0.0, 1.0);

  MyGradient(
      {@required Color startColor,
      @required Color endColor,
      bool horizotal: false,
      double raduis: 0.0})
      : super(
            gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: begin,
                end: (horizotal) ? endHorizotal : endVertical,
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.all(Radius.circular(raduis)));
}
