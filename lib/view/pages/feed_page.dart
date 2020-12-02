import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/tiles/postTile.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  StreamSubscription sub;
  List<Post> posts = [];
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    setupSub();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool scrolled) {
          return [MyAppBar(title: "Fil d'actualite", image: homeImage)];
        },
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            Post post = posts[index];
            User user = users.singleWhere((u) => u.uid == post.userId);
            return PostTile(
              post: post,
              user: user,
              detail: false,
            ); 
          },
        ));
  }

  setupSub() {
    sub = FireHelper()
        .fire_user
        .where(keyFollowers, arrayContains: me.uid)
        .snapshots()
        .listen((datas) {
      getUsers(datas.docs);
      datas.docs.forEach((docus) {
        docus.reference.collection("posts").snapshots().listen((post) {
          setState(() {
            posts = getPosts(post.docs);
          });
        });
      });
    });
  }

  getUsers(List<DocumentSnapshot> userDors) {
    List<User> myList = users;
    userDors.forEach((u) {
      User user = User(u);
      if (myList.every((p) => p.uid != user.documentId)) {
        myList.add(user);
      } else {
        User toBeChanged = myList.singleWhere((p) => p.uid == user.uid);
        myList.remove(toBeChanged);
        myList.add(user);
      }
    });
    setState(() {
      users = myList;
    });
  }

  List<Post> getPosts(List<DocumentSnapshot> postDocs) {
    List<Post> myList = posts;
    //var postDocs = post.docs;
    postDocs.forEach((p) {
      Post post = Post(p);
      if (myList.every((p) => p.documentId != post.documentId)) {
        myList.add(post);
      } else {
        Post toBeChanged =
            myList.singleWhere((p) => p.documentId == post.documentId);
        myList.remove(toBeChanged);
        myList.add(post);
      }
    });

    myList.sort((a, b) => b.date.compareTo(a.date));

    return myList;
  }
}
