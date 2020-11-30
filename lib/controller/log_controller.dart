import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';
import 'package:fluttersocial/util/fire_helper.dart';

class LogController extends StatefulWidget {
  @override
  _LogControllerState createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  PageController _pageController;
  TextEditingController _mail;
  TextEditingController _pwd;
  TextEditingController _name;
  TextEditingController _surname;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    _mail = TextEditingController();
    _pwd = TextEditingController();
    _name = TextEditingController();
    _surname = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _mail.dispose();
    _pwd.dispose();
    _name.dispose();
    _surname.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: SingleChildScrollView(
        child: InkWell(
          onTap: (() => hideKeyboard()),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height >= 650.0)
                  ? MediaQuery.of(context).size.height
                  : 650.0,
              decoration: MyGradient(
                startColor: base,
                endColor: baseAccent,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    PaddingWith(
                        widget: Image(
                      image: logoImage,
                      height: 100.0,
                    )),
                    PaddingWith(
                      widget: Menu2Items(
                        items1: "Connexion",
                        items2: "Création",
                        pageController: _pageController,
                      ),
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    Expanded(
                        flex: 2,
                        child: PageView(
                          controller: _pageController,
                          children: [logView(0), logView(1)],
                        ))
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  Widget logView(int index) {
    return Column(
      children: [
        PaddingWith(
          widget: Card(
              elevation: 7.5,
              color: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: listItems((index == 0)),
                ),
              )),
          top: 15.0,
          bottom: 15.0,
          left: 20.0,
          right: 20.0,
        ),
        PaddingWith(
          widget: ButtonGradient(callback: (() => signIn((index == 0))), text: (index == 0) ? "Se connecter" : "Creer un compte"),
        top: 15.0,
          bottom: 15.0,
        )
      ],
    );
  }

  List<Widget> listItems(bool exists) {
    List<Widget> list = [];
    if (!exists) {
      list.add(MyTextField(
        controller: _surname,
        hint: "Entrez votre prénom",
      ));
      list.add(MyTextField(
        controller: _name,
        hint: "Entrez votre nom",
      ));
    }
    list.add(MyTextField(
      controller: _mail,
      hint: "Entrez votre andresse email",
      type: TextInputType.emailAddress,
    ));
    list.add(MyTextField(
      controller: _pwd,
      hint: "Entrez votre mot de passe",
      obscure: true,
    ));

    return list;
  }

  signIn(bool exists) {
    hideKeyboard();
    if (_mail.text != null && _mail.text != "") {
      if (_pwd.text != null && _pwd.text != "") {
        if (exists) {
          //connexion avec mail et pwd
          FireHelper().signIn(_mail.text, _pwd.text);
        } else {
          //Verivier nom et prenom puis inscription
          if (_name.text != null && _name.text != "") {
            if (_surname.text != null && _name.text != "") {
              //inscription
              FireHelper().createAccout(_mail.text, _pwd.text, _name.text, _surname.text);
            } else {
              //Alerte pas de prenom
              AlertHelper().error(context, "Aucun prenom");
            }
          } else {
            //Alerte pas de nom
            AlertHelper().error(context, "Aucun nom");
          }
        }
      } else {
        //Alert pas de pwd
        AlertHelper().error(context, "Aucun password");
      }
    } else {
      //Alert pas de mail
      AlertHelper().error(context, "Aucun adress mail");
    }
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
