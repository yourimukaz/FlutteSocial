import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/delegate/header_delegate.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class ProfilPage extends StatefulWidget {
  final User user;
  ProfilPage(this.user);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isMe = false;
  ScrollController _controller;
  double expanded = 200.0;
  bool get _showTile {
    return _controller.hasClients &&
        _controller.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    _isMe = (widget.user.uid == me.uid);
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireHelper().postsFrom(widget.user.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingCenter();
          } else {
            List<DocumentSnapshot> document = snapshot.data.docs;
            return CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: expanded,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(
                    title: MyText(widget.user.name),
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: profileImage, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeader(
                      user: widget.user, callback: null, scrolled: _showTile),
                ),
                SliverList(delegate:
                    SliverChildBuilderDelegate((BuildContext context, index) {
                  return ListTile(title: MyText("Nouvelle tile : $index"),);
                }))
              ],
            );
          }
        });
  }
}
