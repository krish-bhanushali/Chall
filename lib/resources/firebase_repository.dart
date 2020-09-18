import 'package:chall/Providerr/imageuploadprovider.dart';
import 'package:chall/models/message.dart';
import 'package:chall/models/user.dart';
import 'package:chall/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FirebaseRepository{

  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Stream<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<User> getUserCurrentlyFutureMethod() => _firebaseMethods.getUserCurrentlyFutureMethod();

  Future<UserClass> getUserDetails () => _firebaseMethods.getUserDetails();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(UserCredential userCredential) => _firebaseMethods.authenticateUser(userCredential);

  Future<void> addDataToDb(UserCredential credential) => _firebaseMethods.addDataToDb(credential);

  Future<void> signOut() => _firebaseMethods.signOut();


  Future<List<UserClass>> fetchAllUsers(User user) => _firebaseMethods.fetchAllUsers(user);

  Future<void> addMessageToDb(Message message,UserClass sender,UserClass receiver) => _firebaseMethods.addMessageToDb(message,sender,receiver);

  void uploadImage({
   @required File image,
    @required String  receiverId,
    @required String  senderId,
    @required ImageUploadProvider imageUploadProvider,


})=> _firebaseMethods.uploadImage(image,receiverId,senderId,imageUploadProvider);

}