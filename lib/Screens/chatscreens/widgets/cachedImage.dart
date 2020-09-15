import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String Url;

  const CachedImage({Key key, this.Url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(imageUrl: Url,
       placeholder: (context, url){
        return Center(child: CircularProgressIndicator());
       },
      ),
    );
  }
}
