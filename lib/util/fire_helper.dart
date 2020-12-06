import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_widgets/constantes.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireHelper {
  //authentification

  final auth_instance = FirebaseAuth.instance;

  Future<UserCredential> signIn(String mail, String pwd) async {
    final UserCredential user = await auth_instance.signInWithEmailAndPassword(
        email: mail, password: pwd);
    return user;
  }

  Future<UserCredential> createAccout(
      String mail, String pwd, String name, String surname) async {
    final UserCredential user = await auth_instance
        .createUserWithEmailAndPassword(email: mail, password: pwd);
    //Creer mon utilisateur pour l'ajout dans la bdd
    String uid = user.user.uid;
    List<dynamic> followers = [uid];
    List<dynamic> following = [];

    Map<String, dynamic> map = {
      keyName: name,
      keySurname: surname,
      keyImageUrl: "",
      keyFollowers: followers,
      keyFollowing: following,
      keyUid: uid
    };
    addUser(uid, map);
    return user;
  }

  logOut() => auth_instance.signOut();

  //Database

  static final data_instance = FirebaseFirestore.instance;

  final fire_user = data_instance.collection("users");

  Stream<QuerySnapshot> postsFrom(String uid) {
    return fire_user.doc(uid).collection("posts").snapshots();
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
  }

  modifyUser(Map<String, dynamic> data) {
    fire_user.doc(me.uid).update(data);
  }

  modifyPicture(File file) {
    StorageReference reference = storage_user.child(me.uid);
    addImage(file, reference).then((finalised) {
      Map<String, dynamic> data = {keyImageUrl: finalised};
      modifyUser(data);
    });
  }

  addLike(Post post) {
    if (post.likes.contains(me.uid)) {
      post.ref.update({
        keyLikes: FieldValue.arrayRemove([me.uid])
      });
    } else {
      post.ref.update({
        keyLikes: FieldValue.arrayUnion([me.uid])
      });
    }
  }

  addPost(String uid, String text, File file) {
    int date = DateTime.now().microsecondsSinceEpoch.toInt();
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyLikes: likes,
      keyComments: comments,
      keyDate: date
    };
    if (text != null && text != "") map[keyText] = text;
    if (file != null) {
      StorageReference ref = storage_posts.child(uid).child(date.toString());
      addImage(file, ref).then((finalised) {
        String imageUrl = finalised;
        map[keyImageUrl] = imageUrl;
        fire_user.doc(uid).collection("posts").doc().set(map);
      });
    } else {
      fire_user.doc(uid).collection("posts").doc().set(map);
    }
  }


  

  //Storage

  static final storage_instance = FirebaseStorage.instance.ref();
  final storage_user = storage_instance.child('users');
  final storage_posts = storage_instance.child('posts');

  Future<String> addImage(File file, StorageReference reference) async {
    StorageUploadTask task = reference.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;
  }
}
