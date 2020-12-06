import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/comment.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/pages/comment_tile.dart';
import 'package:fluttersocial/view/pages/new_post_page.dart';
import 'package:fluttersocial/view/tiles/postTile.dart';

class DetailPage extends StatelessWidget {
  User user;
  Post post;

  DetailPage(this.user, this.post);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: post.ref.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Post newPost = Post(snapshot.data);
            return ListView.builder(
              itemCount: newPost.comments.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return PostTile(
                    post: newPost,
                    user: user,
                    detail: true,
                  );
                } else {
                  Comment comment = Comment(newPost.comments[index - 1]);
                  return CommentTile(comment);
                }
              },
            );
          } else {
            return LoadingCenter();
          }
        });
  }
}
