import 'package:fluttersocial/view/my_material.dart';

class Comment {
  String userId;
  String text;
  String date;

  Comment(Map<String, dynamic> map) {
    userId = map[keyUid];
    text = map[keyText];
    date = DateHelper().myDate(map[keyDate]);
  }
}
