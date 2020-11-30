import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/my_widgets/bar_items.dart';

class MainAppController extends StatefulWidget {
  String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StreamSubscription streamListener;
  User user;
  int index = 0;

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
    return (user == null)
        ? LoadingScaffold()
        : Scaffold(
            key: _globalKey,
            bottomNavigationBar: BottonBar(
              items: [
                BarItem(
                    icon: homeIcon,
                    onPressed: (() => buttonSelected(0)),
                    selected: (index == 0)),
                BarItem(
                    icon: friendsIcon,
                    onPressed: (() => buttonSelected(1)),
                    selected: (index == 1)),
                SizedBox(
                  width: 10,
                ),
                BarItem(
                    icon: notifIcon,
                    onPressed: (() => buttonSelected(2)),
                    selected: (index == 2)),
                BarItem(
                    icon: profilIcon,
                    onPressed: (() => buttonSelected(3)),
                    selected: (index == 3))
              ],
            ),
            body: Center(
              child: MyText(
                user.surname,
                color: baseAccent,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: write,
              child: writeIcon,
              backgroundColor: pointer,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }

  write() {}

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }
}
