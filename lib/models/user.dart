import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersocial/view/my_material.dart';

class User {
  String uid;
  String name;
  String surname;
  String imageUrl;
  List<dynamic> followers;
  List<dynamic> following;
  DocumentReference reference;
  String documentId;
  String description;

  User(DocumentSnapshot snapshot) {
    reference = snapshot.reference;
    documentId = snapshot.id;
    Map<String, dynamic> map = snapshot.data();
    uid = map[keyUid];
    name = map[keyName];
    surname = map[keySurname];
    followers = map[keyFollowers];
    following = map[keyFollowing];
    imageUrl = map[keyImageUrl];
    description = map[keyDescription];
  }

  Map<String, dynamic> toMap() {
    return {
      keyUid: uid,
      keyName: name,
      keySurname: surname,
      keyFollowers: followers,
      keyFollowing: following,
      keyImageUrl: imageUrl,
      keyDescription: description
    };
  }
}
