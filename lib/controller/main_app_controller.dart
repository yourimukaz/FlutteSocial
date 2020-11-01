import 'package:flutter/material.dart';

class MainAppController extends StatefulWidget {
  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Main"),
      ),
    );
  }
}
