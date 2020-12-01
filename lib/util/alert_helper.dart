import 'package:flutter/material.dart';
import 'package:fluttersocial/util/fire_helper.dart';
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

  Future<void> disconnect(BuildContext context) async {
    MyText title = MyText(
      "Voulez-vous vous deconnnecter ? ",
      color: base,
    );
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            actions: [close(context, "NOM"), disconnectBtn(context)],
          );
        });
  }

  Future<void> changeUserAlert(BuildContext context,
      {@required TextEditingController name,
      @required TextEditingController surname,
      @required TextEditingController desc}) async {
    MyTextField nameTF = MyTextField(
      controller: name,
      hint: me.name,
    );
    MyTextField surnameTF = MyTextField(controller: surname, hint: me.surname);
    MyTextField descTF = MyTextField(
      controller: desc,
      hint: me.description ?? "Aucune description",
    );
    MyText title = MyText(
      "Changer les donnees de l'utilisateur",
      color: pointer,
    );
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            content: Column(
              children: [nameTF, surnameTF, descTF],
            ),
            actions: [
              close(context, "Annuler"),
              FlatButton(
                  onPressed: () {
                    Map<String, dynamic> data = {};
                    if (name.text != null && name.text != "")
                      data[keyName] = name.text;
                    if (surname.text != null && surname.text != "")
                      data[keySurname] = surname.text;
                    if (desc.text != null && desc.text != "")
                      data[keyDescription] = desc.text;
                    FireHelper().modifyUser(data);
                    Navigator.pop(context);
                  },
                  child: MyText("Valider", color: Colors.blue,))
            ],
          );
        });
  }

  FlatButton disconnectBtn(BuildContext context) {
    return FlatButton(
        onPressed: () {
          FireHelper().logOut();
          Navigator.pop(context);
        },
        child: MyText(
          "OUI",
          color: Colors.blue,
        ));
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
