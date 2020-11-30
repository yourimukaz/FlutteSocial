import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttersocial/view/my_material.dart';

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
    List<dynamic> followers = [];
    List<dynamic> following = [uid];

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

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
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
