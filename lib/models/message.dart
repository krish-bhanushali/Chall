import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timeStamp;
  String photoUrl;
  Message(
  {
    this.senderId,this.receiverId,this.type,this.message,this.timeStamp
}
      );

  Message.imageMessage({
    this.senderId,this.receiverId,this.type,this.message,this.timeStamp, this.photoUrl
});

  Map toMap(){
    var map = Map<String,dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timeStamp;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map){

    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.type = map['type'];
    this.message = map['message'];
    this.timeStamp = map['timestamp'];

  }


}