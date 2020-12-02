import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_h.dart';
import 'package:fluttersocial/view/my_material.dart';

class FollowButton extends FlatButton {
  FollowButton({@required User user})
      : super(
            child: MyText(
              me.following.contains(user.uid) ? "Ne pas suivre" : "Suivre",
              color: pointer,
            ),
            onPressed: () {
              FireH().addFollow(user);
            });
}
