import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_material.dart';

class Post {
  DocumentReference ref;
  String documentId;
  String id;
  String text;
  String userId;
  String imagesUrl;
  int date;
  List<dynamic> likes;
  List<dynamic> comments;
  User user;

  Post(User user, DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    documentId = snapshot.id;
    user = user;
    Map<String, dynamic> map = snapshot.data();
    id = map[keyPostId];
    text = map[keyText];
    userId = map[keyUid];
    imagesUrl = map[keyImageUrl];
    date = map[keyDate];
    likes = map[keyLikes];
    comments = map[keyComments];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      keyPostId: id,
      keyUid: userId,
      keyDate: date,
      keyLikes: likes,
      keyComments: comments
    };

    if (text != null) map[keyText] = text;
    if (imagesUrl != null) map[keyImageUrl] = imagesUrl;

    return map;
  }
}
