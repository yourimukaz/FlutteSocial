import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/view/my_widgets/constantes.dart';

class FireH{
  
addFollow(User autre) {
    if (me.following.contains(autre.uid)) {
      me.reference.update({
        keyFollowing: FieldValue.arrayRemove([autre.uid])
      });
      autre.reference.update({
        keyFollowers: FieldValue.arrayRemove([me.uid])
      });
    } else {
      me.reference.update({
        keyFollowing: FieldValue.arrayUnion([autre.uid])
      });
      autre.reference.update({
        keyFollowers: FieldValue.arrayUnion([me.uid])
      });
    }
  }
}