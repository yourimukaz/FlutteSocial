import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/view/my_material.dart';

class ProfileImage extends InkWell {
  ProfileImage(
      {double size: 20.0,
      @required String urlString,
      @required VoidCallback onPresse})
      : super(
        onTap: onPresse,
        child: CircleAvatar(
          radius: size,
          backgroundImage: (urlString != null && urlString != "null") ? CachedNetworkImageProvider(urlString): logoImage,
          backgroundColor: white,
        )
      );
}
