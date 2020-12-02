import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class MyAppBar extends SliverAppBar {
  MyAppBar(
      {@required String title,
      @required AssetImage image,
      double height: 150.0})
      : super(
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: MyText(title, color: white,),
          background: Image(image: image,fit: BoxFit.cover,),
        ),
        expandedHeight: height
      );
}
