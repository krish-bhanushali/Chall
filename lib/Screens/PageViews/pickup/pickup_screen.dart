import 'package:chall/Screens/chatscreens/widgets/cachedImage.dart';
import 'package:chall/models/call.dart';
import 'package:chall/resources/call_methods.dart';
import 'package:chall/utils/permissions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../call_screen.dart';


class PickupScreen extends StatelessWidget {

  final Call call;
  final CallMethods _callMethods = CallMethods();

  PickupScreen({Key key, this.call}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Incoming......',style: TextStyle(
              fontSize: 30,
            ),),
            SizedBox(
              height: 50,
            ),
            CachedImage(
              Url: call.callerPic,
              isRound: true,
              radius: 180,
            ),

            SizedBox(
              height: 15,
            ),
            Text(call.callerName,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.call_end,color: Colors.red,), onPressed: () async {
                  await _callMethods.endCall(call:call);
                }),
                SizedBox(
                  width: 75,
                ),
                IconButton(icon: Icon(Icons.call,color: Colors.green,), onPressed: () async =>
                await Permissions.cameraAndMicrophonePermissionsGranted() ?
                Navigator.push(context, MaterialPageRoute(builder: (_)  => CallScreen(call:call))) : {

                }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
