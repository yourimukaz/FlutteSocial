import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/pages/profil_page.dart';

class UserTile extends StatelessWidget {
  User user;
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: base,
            body: SafeArea(child:ProfilPage(user)),
          );
        }));
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          color: white,
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImage(urlString: user.imageUrl, onPresse: null),
                    SizedBox(width: 10.0),
                    MyText(
                      "${user.surname} ${user.name}",
                      color: baseAccent,
                    ),
                  ],
                ),
                (user.uid == me.uid)
                    ? Container(
                        width: 0.0,
                      )
                    : FollowButton(user: user)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
