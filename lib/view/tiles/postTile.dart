import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/models/posts.dart';
import 'package:fluttersocial/models/user.dart';
import 'package:fluttersocial/util/fire_helper.dart';
import 'package:fluttersocial/view/my_material.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final User user;
  final bool detail;

  PostTile({@required this.post, @required this.user, this.detail: false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        elevation: 5.0,
        child: PaddingWith(
          top: 10.0,bottom: 10.0,right: 10.0,left: 10.0,
          widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileImage(urlString: user.imageUrl, onPresse: null),
                Column(
                  children: [
                    MyText("${user.surname} ${user.name}", color: baseAccent,),
                    MyText(DateHelper().myDate(post.date), color: pointer,)
                  ],
                )
              ],
            ),

            (post.imagesUrl != null && post.imagesUrl != "" ) 
            ? PaddingWith(widget: Container(width: MediaQuery.of(context).size.width,height: 1.0,color: baseAccent,)): Container(height: 0.0,),

            (post.imagesUrl != null && post.imagesUrl != "")
            ? PaddingWith(widget: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(image: CachedNetworkImageProvider(post.imagesUrl), fit: BoxFit.fitWidth)
                ) 
              )
            ): Container(height: 0.0,color: pointer),

            (post.text != null && post.text != "") 
            ? PaddingWith(widget: Container(width: MediaQuery.of(context).size.width,height: 1.0,color: baseAccent,)): Container(height: 0.0,),

            (post.text != null && post.text != "") ?
            PaddingWith(widget: MyText(post.text, color: baseAccent,)):
            Container(height: 0.0,),
            PaddingWith(widget: Container(width: MediaQuery.of(context).size.width,height: 1.0,color: baseAccent,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: (post.likes.contains(user.uid)? likeFull:likeEmpty), onPressed: () => FireHelper().addLike(post)),
                MyText(post.likes.length.toString(), color: baseAccent,),
                IconButton(icon: msgIcon, onPressed: null),
                MyText(post.comments.length.toString(), color: baseAccent,)
              ],
            ) 
          ],
        )),
      ),
    );
  }
}
