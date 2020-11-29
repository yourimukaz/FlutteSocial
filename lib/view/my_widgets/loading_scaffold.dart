import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class LoadingScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LoadingCenter(),) ,
    );
  }
}
