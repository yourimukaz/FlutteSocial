import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: base,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: InkWell(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: Column(
            children: [
              PaddingWith(
                widget: MyText(
                  "Ecrivez quelque chose ......",
                  color: base,
                  fontSize: 30.0,
                ),
                top: 25.0,
              ),
              PaddingWith(
                  widget: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: baseAccent)),
              PaddingWith(
                widget: MyTextField(
                  controller: _controller,
                  hint: "Exprimez-vous",
                  icon: writeIcon,
                ),
                top: 25.0,
                right: 25.0,
                left: 25.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
