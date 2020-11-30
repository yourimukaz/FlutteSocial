import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText("Profil"),
    );
  }
}
