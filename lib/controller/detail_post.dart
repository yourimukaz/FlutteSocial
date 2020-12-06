import 'package:flutter/material.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class DetailPost extends StatelessWidget {
  User user;
  Post post;

  DetailPost(this.user, this.post);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: base,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Colors.pink,
            ),
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: baseAccent,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 75.0,
            color: baseAccent,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 100.0,
                  child: MyTextField(
                    controller: controller,
                    hint: "Ecrivez un commentaire",
                  ),
                ),
                IconButton(
                    icon: sendIcon,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (controller.text != null && controller.text != "") {
                        FireHelper().addComment(post.ref, controller.text);
                      }
                    })
              ],
            ),
          )
        ],
      )),
    );
  }
}
