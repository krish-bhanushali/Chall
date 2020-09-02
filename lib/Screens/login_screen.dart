import 'package:chall/resources/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return loginButton();
  }

  Widget loginButton(){
    return FlatButton(
        padding: EdgeInsets.all(35),
        onPressed: ()=>performLogin, child: Text('LOGIN',
      style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2
      ),


    )


    );
  }

  void performLogic(){
    _repository.signIn().then((UserCredential credentials){
      if(credentials != null){

      }else{
        //error
      }
    });
  }
}
