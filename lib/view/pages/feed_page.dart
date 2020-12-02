import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool scrolled) {
          return [MyAppBar(title: "Fil d'actualite", image: homeImage)];
        },
        body: LoadingCenter());
  }
}
