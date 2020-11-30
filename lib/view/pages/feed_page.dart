import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Fil d'actualiter"));
  }
}
