import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageCard extends StatelessWidget {
  
  final image;

  UserImageCard({
    
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 569,
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          );
  }
}
