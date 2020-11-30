import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText("Notification"),
    );
  }
}
