import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';


class MyUtils {
  static String getUsername(String email){

    return "live:${email.split('@')[0]}";
  }

  static Future<String> getInitials(String name) async{

    print(name);
    List<String> nameSplit = name.split(" ");
    print(nameSplit);
    String firstNameInitial = nameSplit[0][0];
    String LastNameInitial = nameSplit[1][0];

    return firstNameInitial+LastNameInitial;
  }

  static Future<File> pickImage({@required ImageSource source}) async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    return compressImage(File(pickedFile.path));
  }

  static Future<File> compressImage(File imageToCompress) async {
   final tempDir = await getTemporaryDirectory();
   final path = tempDir.path;
   int random = Random().nextInt(10000);
   im.Image ImageD = im.decodeImage(imageToCompress.readAsBytesSync());
   im.copyResize(ImageD, width: 500,height: 500);

   return new File('$path/img_$random.jpg')..writeAsBytesSync(im.encodeJpg(ImageD, quality: 85));

  }
}