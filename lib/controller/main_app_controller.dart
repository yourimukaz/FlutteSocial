import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    streamListener =
        FireHelper().fire_user.doc(widget.uid).snapshots().listen((documnet) {
      print(documnet.data());
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
    return LoadingScaffold();
  }
}
