import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/tiles/user_tile.dart';

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
                    MyAppBar(title: "Liste des utilisateurs",image: eventImage,)
                  ];
                },
                body: ListView.builder(
                  itemCount: documnets.length,
                  itemBuilder: (BuildContext context, int index) {
                    User user = User(documnets[index]);
                    return UserTile(user);
                  },
                ));
          } else {
            return LoadingCenter();
          }
        });
  }
}
