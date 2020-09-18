import 'dart:math';

import 'package:chall/Screens/call_screen.dart';
import 'package:chall/models/call.dart';
import 'package:chall/models/user.dart';
import 'package:chall/resources/call_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static dial({UserClass from, UserClass to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),

    );

    bool callMade = await callMethods.makeCall(call: call);
    call.hasDialled = true;
    if(callMade){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> CallScreen(call: call,)));

    }
  }
}
