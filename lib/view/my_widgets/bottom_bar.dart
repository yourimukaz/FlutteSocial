import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class BottonBar extends BottomAppBar {

  BottonBar({@required List<Widget> items}) : super(

    color: baseAccent,
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: items,
    )

    );
}