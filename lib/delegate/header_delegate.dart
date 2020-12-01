import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_material.dart';

class MyHeader extends SliverPersistentHeaderDelegate {
  User user;
  VoidCallback callback;
  bool scrolled;

  MyHeader(
      {@required this.user, @required this.callback, @required this.scrolled});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        padding: EdgeInsets.all(10.0),
        color: baseAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            (scrolled)
                ? Container(width: 0.0, height: 0.0)
                : MyText("${user.surname} ${user.name}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileImage(urlString: user.imageUrl, onPresse: null),
                    MyText((user.description == null) ? ("Aucun description"): user.description )
                  ],
                ),
                Container(width: MediaQuery.of(context).size.width,height: 1.0,color: base,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(child: MyText("Followers: ${user.followers.length} "),),
                    InkWell(child: MyText("Following: ${user.following.length - 1}"),)
                  ],
                )
          ],
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => (scrolled) ? 150.0 : 200.0;

  @override
  // TODO: implement minExtent
  double get minExtent => (scrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(MyHeader oldDelegate) {
    // TODO: implement shouldRebuild
    return scrolled != oldDelegate.scrolled || user != oldDelegate.user;
  }
}
