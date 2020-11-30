import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/my_widgets/bar_items.dart';
import 'package:fluttersocial/view/pages/feed_page.dart';
import 'package:fluttersocial/view/pages/new_post_page.dart';
import 'package:fluttersocial/view/pages/notif_page.dart';
import 'package:fluttersocial/view/pages/profil_page.dart';
import 'package:fluttersocial/view/pages/users_page.dart';

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
            backgroundColor: base,
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
            body: showPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: write,
              child: writeIcon,
              backgroundColor: pointer,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }

  write() {
    _globalKey.currentState.showBottomSheet((builder) => NewPost());
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  Widget showPage() {
    switch (index) {
      case 0:
        return FeedPage();
      case 1:
        return UsersPage();
      case 2:
        return NotifPage();
      default:
        return ProfilPage();
    }
  }
}
