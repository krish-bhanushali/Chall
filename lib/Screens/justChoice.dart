import 'package:chall/Screens/Welcome.dart';
import 'package:chall/Screens/login.dart';
import 'package:chall/resources/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseRepository _firebaseRepository = FirebaseRepository();
class RenderChoice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _firebaseRepository.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          return WelcomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
