

import 'package:chall/Globals/constants.dart';
import 'package:chall/Screens/Welcome.dart';
import 'package:chall/resources/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginPressed = false;


  FirebaseRepository _firebaseRepository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
        body: Stack(
      children: [
//        Container(
//          height: double.infinity,
//          width: double.infinity,
//          child: Lottie.asset('assets/background.json',
//              height: double.infinity, fit: BoxFit.fill),
//        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
//              Container(
//                width: double.infinity,
//                height: 250.0,
//                child: Lottie.asset('assets/chat.json',
//                    alignment: Alignment.center),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
//                child: Container(
//                  height: 50,
//                  width: MediaQuery.of(context).size.width,
//                  child: TextField(
//                    style: TextStyle(
//                      color: Colors.white,
//                    ),
//                    decoration: InputDecoration(
//
//                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
//                     icon: Icon(Icons.mail_outline,color: Colors.white,),
//                      fillColor: Colors.lightBlueAccent,
//                      labelText: 'Email',
//                      labelStyle: TextStyle(
//                        color: Colors.white70,
//                        fontSize: 25
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              Padding(
//                padding: const EdgeInsets.only( left: 50, right: 50),
//                child: Container(
//                  height: 50,
//                  width: MediaQuery.of(context).size.width,
//                  child: TextField(
//                    obscureText: true,
//                    style: TextStyle(
//
//                      color: Colors.white,
//                    ),
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
//                      icon: Icon(Icons.remove_red_eye,color: Colors.white,),
//                      fillColor: Colors.lightBlueAccent,
//                      labelText: 'Password',
//                      labelStyle: TextStyle(
//                          color: Colors.white70,
//                          fontSize: 25
//                      ),
//                    ),
//                  ),
//                ),
//              ),
              Stack(
                children: [

                  Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: UniversalVariables.senderColor,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        onPressed: (){
                          setState(() {
                            isLoginPressed = true;
                          });
                      //here we sign in using google to Firebase and get the userCredential
                        _firebaseRepository.signIn().then((userCrendentValue) {
                          //if the signIn was successful
                          if (userCrendentValue != null) {
                            //Now here we go to database and see whether the user exists there or not
                            //Firebase inbuilt keeps the log of everything you know from the googleCredentials we only just
                            //store that into our cloudFirestore

                            //So in next function we go to this function we check that it exists or not , firebase will allow it to sign in by default
                            //But we need to have entry in the data base
                                _firebaseRepository.authenticateUser(userCrendentValue).then((isNewUser) {

                                  if(isNewUser){
                                   _firebaseRepository.addDataToDb(userCrendentValue).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomeScreen())));
                                  }
                                  else{
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomeScreen()));

                                  }
                                });
                          }
                          else{
                            print('failed to signIn');
                          }
                        });



                    }, child: Text('Login') ),
                  ),
                  isLoginPressed ? Center(
                    child: CircularProgressIndicator(),
                  ) : Container(),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
