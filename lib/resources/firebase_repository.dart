import 'package:chall/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository{

  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Stream<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(UserCredential userCredential) => _firebaseMethods.authenticateUser(userCredential);

  Future<void> addDataToDb(UserCredential credential) => _firebaseMethods.addDataToDb(credential);

}