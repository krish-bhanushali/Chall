import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String Url;
  final bool isRound;
  final double radius;
  final double height;
  final double width;
  final BoxFit fit;

  final String noImageAvailable = "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";


  CachedImage({Key key, this.Url, this.isRound, this.radius, this.height, this.width, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      try {
        return  SizedBox(
          height: isRound ? radius : height,
          width: isRound ? radius : width,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(isRound ? 50 : radius),
            child: CachedNetworkImage(
              imageUrl: Url,
              fit: fit,
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) =>
                  Image.network(noImageAvailable, fit: BoxFit.cover,),
            ),
          ),
        );
      } catch(E){
        print(E);
      return Image.network(noImageAvailable,fit: BoxFit.cover,);
      }
  }
}
