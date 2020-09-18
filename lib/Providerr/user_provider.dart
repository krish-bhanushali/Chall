import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:chall/models/user.dart';
import 'package:chall/resources/firebase_repository.dart';



class UserProvider with ChangeNotifier{
  UserClass _user;
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  UserClass get getUser => _user;

  void refreshUser() async {
    UserClass user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();

  }
}