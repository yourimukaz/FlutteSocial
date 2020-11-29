import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class MainAppController extends StatefulWidget {
  String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {
  StreamSubscription streamListener;
  User user;

  @override
  void initState() {
    // TODO: implement initState
    streamListener =
        FireHelper().fire_user.doc(widget.uid).snapshots().listen((document) {
      setState(() {
        user = User(document);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (user == null) ? LoadingScaffold() : Scaffold(body: Center(child: MyText(user.surname,color: baseAccent ,),),);
  }
}
