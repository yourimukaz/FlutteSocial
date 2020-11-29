import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class AlertHelper {
  Future<void> error(BuildContext context, String text) async {
    MyText title = MyText(
      "Error",
      color: Colors.black,
    );
    MyText subtitle = MyText(
      text,
      color: Colors.black,
    );
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            content: subtitle,
            actions: [close(context, "OK")],
          );
        });
  }

  FlatButton close(BuildContext context, String text) {
    return FlatButton(
        onPressed: (() => Navigator.pop(context)),
        child: MyText(
          text,
          color: pointer,
        ));
  }
}
