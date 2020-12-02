import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireHelper().fire_user.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documnets = snapshot.data.docs;
            return NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool scrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: MyText(
                          "Liste d'utilisateur",
                          color: baseAccent,
                        ),
                        background: Image(
                          image: eventImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      expandedHeight: 150.0,
                    )
                  ];
                },
                body: ListView.builder(
                  itemCount: documnets.length,
                  itemBuilder: (BuildContext context, int index) {
                    User user = User(documnets[index]);
                    return ListTile(
                      leading: ProfileImage(urlString: user.imageUrl, onPresse: null),
                      title: MyText("${user.surname} ${user.name}", color: baseAccent,),
                      trailing: FollowButton(user: user),
                    );
                  },
                ));
          } else {
            return LoadingCenter();
          }
        });
  }
}
