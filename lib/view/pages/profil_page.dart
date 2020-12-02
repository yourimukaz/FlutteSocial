import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/delegate/header_delegate.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/view/tiles/postTile.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPage extends StatefulWidget {
  final User user;
  ProfilPage(this.user);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isMe = false;
  ScrollController _controller;
  TextEditingController _name;
  TextEditingController _surname;
  TextEditingController _desc;
  double expanded = 200.0;
  bool get _showTitle {
    return _controller.hasClients &&
        _controller.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    _isMe = (widget.user.uid == me.uid);
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });

    _name = TextEditingController();
    _surname = TextEditingController();
    _desc = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _name.dispose();
    _surname.dispose();
    _desc.dispose();
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
                  actions: [
                    (_isMe)
                        ? IconButton(
                            icon: settingIcon,
                            color: pointer,
                            onPressed: () => AlertHelper().disconnect(context))
                        : MyText("Suivre ou ne plus suivre")
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: _showTitle
                        ? MyText(widget.user.surname + " " + widget.user.name)
                        : MyText(""),
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: profileImage, fit: BoxFit.cover)),
                      child: Center(
                        child: ProfileImage(
                            urlString: widget.user.imageUrl,
                            size: 75.0,
                            onPresse: changeUser),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeader(
                      user: widget.user, callback: changeFields, scrolled: _showTitle),
                ),
                SliverList(delegate:
                    SliverChildBuilderDelegate((BuildContext context, index) {
                  if (index == document.length)
                    return ListTile(
                      title: MyText("Fin de liste"),
                    );
                  if (index > document.length) return null;
                  Post post = Post(document[index]);
                  return PostTile(post: post, user: widget.user);
                }))
              ],
            );
          }
        });
  }

  void changeFields() {
    AlertHelper()
        .changeUserAlert(context, name: _name, surname: _surname, desc: _desc);
  }

  void changeUser() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: Colors.transparent,
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.all(7.2),
              child: Container(
                color: base,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyText("Modification de la photo de profil"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: camIcon,
                            onPressed: () {
                              takePicture(ImageSource.camera);
                              Navigator.pop(context);
                            }),
                        IconButton(
                            icon: libraryIcon,
                            onPressed: () {
                              takePicture(ImageSource.gallery);
                              Navigator.pop(context);
                            })
                      ],
                    )
                    /*  MyTextField(
                      controller: _name ,hint: widget.user.name,
                    ),
                    MyTextField(
                      controller: _surname ,hint: widget.user.surname,
                    ),
                    MyTextField(
                      controller: _desc ,hint: widget.user.description ?? "Aucune description",
                    ),
                    ButtonGradient(callback: validate, text: "Valider les Changements") */
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> takePicture(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source, maxHeight: 300.0, maxWidth: 300.0);
    FireHelper().modifyPicture(file);
  }

  validate() {}
}
