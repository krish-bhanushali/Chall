import 'package:chall/Globals/Strings.dart';
import 'package:chall/Providerr/imageuploadprovider.dart';
import 'package:chall/models/message.dart';
import 'package:chall/models/user.dart';
import 'package:chall/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StorageReference _storageReference;

  UserClass userClass = UserClass();


  Stream<User> getCurrentUser() {
    return _auth.authStateChanges();
  }

  Future<User> getUserCurrentlyFutureMethod() async{
    return _auth.currentUser;
  }

  Future<UserCredential> signIn() async {
    //Opens Interactive Console for sign In
    googleUser = await GoogleSignIn().signIn();
    if(googleUser!=null){
      //If User selects something
      //We get the credential required for the firebase
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if(googleAuth.idToken !=null && googleAuth.accessToken != null){
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await _auth.signInWithCredential(credential);
      }
    }
  }

  Future<bool> authenticateUser(UserCredential userCredential) async {

    QuerySnapshot results = await firestore.collection(User_Collection).where(Email_Field,isEqualTo: userCredential.user.email).get();
    final List<DocumentSnapshot> docs = results.docs;

    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(UserCredential credential) async {
    String username = MyUtils.getUsername(credential.user.email);

   userClass = UserClass(
     uid: credential.user.uid,
     email: credential.user.email,
     name: credential.user.displayName,
     profilePhoto: credential.user.photoURL,
     username: username
   );

   firestore.collection(User_Collection).doc(credential.user.uid).set(userClass.toMap(userClass));



  }


  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    return await _auth.signOut();
  }

  Future<List<UserClass>> fetchAllUsers(User user) async{
    List<UserClass> userList = List<UserClass>();
    QuerySnapshot querySnapshot = await firestore.collection(User_Collection).get();
    for(var i = 0; i < querySnapshot.docs.length ; i++){
      if(querySnapshot.docs[i].id != user.uid){
        userList.add(UserClass.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

  Future<void> addMessageToDb(Message message,UserClass sender,UserClass receiver) async{
    var map = message.toMap();
    await firestore.collection(Messages_Collection).doc(message.senderId).collection(message.receiverId).add(map);

    return await firestore.collection(Messages_Collection).doc(message.receiverId).collection(message.senderId).add(map);

  }

  Future<String> uploadImageToStorage(File image) async {
    try{
      _storageReference = FirebaseStorage.instance.ref().child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask _storageUploadTask = _storageReference.putFile(image);

      var url = await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    }catch(E){
      print(E);
      return null;
    }
  }
  void setImageMsg(String url, String receiverId, String senderId ) async {
    Message _message;
    _message = Message.imageMessage(message: "IMAGE",receiverId: receiverId,senderId: senderId,photoUrl: url,timeStamp: Timestamp.now(),type: 'image');
    var map = _message.toImageMap();

    await firestore.collection(Messages_Collection).doc(_message.senderId).collection(_message.receiverId).add(map);

    await firestore.collection(Messages_Collection).doc(_message.receiverId).collection(_message.senderId).add(map);


  }

  void uploadImage(File image,String receiverId, String senderId, ImageUploadProvider imageUploadProvider) async{
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image);

    imageUploadProvider.setToIdle();
    setImageMsg(url,receiverId,senderId);
  }

}