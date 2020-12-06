import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/comment.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class CommentTile extends StatelessWidget {
  Comment comment;

  CommentTile(this.comment);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireHelper().fire_user.doc(comment.userId).snapshots(),
        builder: (BuildContext cxt, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            User user = User(snapshot.data);
            return Container(
              color: white,
              margin: EdgeInsets.only(left: 5.0, right: 5.0,top: 2.5),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ProfileImage(urlString: user.imageUrl, onPresse: null, size: 15.0, ),
                          MyText("${user.surname}" "${user.name}", color: base,)
                        ],
                      ),
                      MyText(comment.date, color: pointer,)
                    ],
                  ),
                  MyText(comment.text, color: baseAccent,)
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
