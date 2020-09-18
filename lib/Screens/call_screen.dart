import 'dart:async';
import 'dart:ui';


import 'package:chall/Providerr/user_provider.dart';
import 'package:chall/configs/agoraConfigs.dart';
import 'package:chall/models/call.dart';
import 'package:chall/resources/call_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';




class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({Key key, this.call}) : super(key: key);
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CallMethods callMethods = CallMethods();
  UserProvider userProvider;

  //For agora



  StreamSubscription callStreamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPostFrameCallback();
    print('gothere');

  }




  /// Add agora event handlers



  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context,listen: false);

      callStreamSubscription = callMethods.callStream(uid: userProvider.getUser.uid).listen(
          (DocumentSnapshot ds){
            switch(ds.data()){
              case null :
                Navigator.pop(context);
                break;
              default :
                break;
            }
          }
      );

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    callStreamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
             FlatButton(onPressed: ()=> callMethods.endCall(call: widget.call), child: Text('End Call',style: TextStyle(
               color: Colors.white
             ),)),

          ],
        ),
      ),
    );
  }



  /// Toolbar layout



  /// Info panel to show logs

}
