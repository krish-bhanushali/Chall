import 'package:chall/models/user.dart';
import 'package:chall/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

    QuerySnapshot results = await firestore.collection("users").where("email",isEqualTo: userCredential.user.email).get();
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

   firestore.collection("users").doc(credential.user.uid).set(userClass.toMap(userClass));



  }


  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    return await _auth.signOut();
  }

  Future<List<UserClass>> fetchAllUsers(User user) async{
    List<UserClass> userList = List<UserClass>();
    QuerySnapshot querySnapshot = await firestore.collection("users").get();
    for(var i = 0; i < querySnapshot.docs.length ; i++){
      if(querySnapshot.docs[i].id != user.uid){
        userList.add(UserClass.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }



}