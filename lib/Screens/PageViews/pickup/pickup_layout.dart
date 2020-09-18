import 'package:chall/Providerr/user_provider.dart';
import 'package:chall/Screens/PageViews/pickup/pickup_screen.dart';
import 'package:chall/models/call.dart';
import 'package:chall/resources/call_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({Key key, this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null) ?
    StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(uid: userProvider.getUser.uid ),
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data.data() != null){
          Call call = Call.fromMap(snapshot.data.data());
          if(!call.hasDialled) {
            return PickupScreen(
              call: call,
            );
          }
          else{
            return scaffold;
          }
        }
        else{
          return scaffold;
        }
      },
    ) : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
