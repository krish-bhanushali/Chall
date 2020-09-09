import 'package:chall/Globals/Strings.dart';
import 'package:chall/Globals/constants.dart';
import 'package:chall/Widgets/Appbar.dart';
import 'package:chall/Widgets/customtile.dart';
import 'package:chall/models/message.dart';
import 'package:chall/models/user.dart';
import 'package:chall/resources/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  final UserClass receiver;

  const ChatScreen({Key key, this.receiver}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  bool isWriting = false;

  UserClass sender;
  String _currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseRepository.getUserCurrentlyFutureMethod().then((user) {
      setState(() {
        _currentUserId = user.uid;
        sender = UserClass(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoURL,

        );
      });
    }


    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      body: Column(
        children: [
          Flexible(child: messageList()),
          chatControls(),
        ],
      ),
    );
  }
  Widget messageList(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(Messages_Collection).doc(_currentUserId).collection(widget.receiver.uid).orderBy(TimeStamp_Data,descending: true).snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.data == null){
          return Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return chatMessageItem(snapshot.data.docs[index]);
            });
      },
    );
  }


  Widget chatMessageItem(QueryDocumentSnapshot snapshot){

    Message _message = Message.fromMap(snapshot.data());
    return Column(
      crossAxisAlignment: _message.senderId == _currentUserId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(


          child: Container(


            child: _message.senderId == _currentUserId ? senderLayout(_message) : receiverLayout(_message),
          ),
        ),
      ],
    );
  }

  Widget senderLayout(Message message){
    Radius messageRdius = Radius.circular(10);

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),

      margin: EdgeInsets.only(top: 12),

    decoration: BoxDecoration(
        color: UniversalVariables.senderColor,
        borderRadius: BorderRadius.only(
            topLeft: messageRdius,topRight: messageRdius,bottomLeft: messageRdius
        )
    ),
      child: Padding(padding: EdgeInsets.all(10),
      child: getMessage(message)
      ),
    );


  }

  getMessage(Message message){
    return Text(

      message != null ? message.message : "",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16
    ),);
  }

  Widget receiverLayout(Message message){
    Radius messageRdius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      decoration: BoxDecoration(
          color: UniversalVariables.senderColor,
          borderRadius: BorderRadius.only(
              bottomRight: messageRdius,topRight: messageRdius,bottomLeft: messageRdius
          )
      ),
      child: Padding(padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );

  }

  Widget chatControls(){

    setWriting(bool writing){
      setState(() {
        isWriting = writing;
      });
    }

    addMediaModel(BuildContext context){
      return showModalBottomSheet(context: context,
          elevation: 0,
          backgroundColor: UniversalVariables.blackColor,


          builder: (context){
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      FlatButton(onPressed: (){
                        Navigator.maybePop(context);
                      }
                      , child: Icon(Icons.close,color: Colors.white,)),
                      Expanded(child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Content & Tools',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),

                      ),

                    ],
                  ),
                ),
                Flexible(child: ListView(
                  children: [
                        ModalTile(
                          title: "Media",
                          subtitle: "Share Photos and Videos",
                          icon: Icons.image,
                        ),
                    ModalTile(
                      title: "File",
                      subtitle: "Share Files",
                      icon: Icons.tab,
                    ),
                    ModalTile(
                      title: "Contact",
                      subtitle: "Share Contacts",
                      icon: Icons.contacts,
                    ),
                    ModalTile(
                      title: "Location",
                      subtitle: "Share a location",
                      icon: Icons.add_location,
                    ),
                    ModalTile(
                      title: "Schedule Call",
                      subtitle: "Arrange a call and get Reminders",
                      icon: Icons.schedule,
                    ),
                    ModalTile(
                      title: "Create Poll",
                      subtitle: "Share Polls",
                      icon: Icons.poll,
                    )
                  ],
                ))
              ],
            );
          });
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
            onTap : () => addMediaModel(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: UniversalVariables.fabGradient,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(child:
          TextField(
            controller: _textEditingController,
            style: TextStyle(
              color: Colors.white
            ),
            onChanged: (val){
              (val.length > 0 && val.trim() != "") ? setWriting(true) : setWriting(false);
            },
            decoration: InputDecoration(
              hintText: "Type a Message",
              hintStyle: TextStyle(
                color: UniversalVariables.greyColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide.none,

              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              filled: true,
              fillColor: UniversalVariables.separatorColor,
              suffix: GestureDetector(
                onTap: (){},
                child: Icon(Icons.face),

              )
            ),
          )),
          isWriting ? Container() : Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.record_voice_over,color: Colors.white,),

          ),
          isWriting ? Container() : Icon(Icons.camera_alt,color: Colors.white,),

          isWriting ? Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: UniversalVariables.fabGradient,
              shape:BoxShape.circle,

            ),
            child: IconButton(icon: Icon(Icons.send,size: 15,), onPressed: (){
                  sendMessage();
            }),

          ): Container(),

        ],
      ),
    );
  }

  sendMessage(){
    var text = _textEditingController.text;
    Message _message = Message(
      receiverId: widget.receiver.uid,
      senderId: sender.uid,
      message: text,
      timeStamp: Timestamp.now(),
      type: 'text'


    );

    setState(() {
      isWriting = false;
    });
    _textEditingController.text = "";

    _firebaseRepository.addMessageToDb(_message,sender,widget.receiver);
  }
  CustomAppBar customAppBar(BuildContext context){
    return CustomAppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed:(){
        Navigator.pop(context);
      }),
      centerTitle: false,
      title: Text(widget.receiver.name),
      actions: [
        IconButton(icon: Icon(Icons.video_call), onPressed: (){

        }),
        IconButton(icon: Icon(Icons.phone), onPressed: (){

        }),

      ],
    );
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ModalTile({Key key, this.title, this.subtitle, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0),
      child: CustomTile(
        mini: false,

        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UniversalVariables.receiverColor,
          ),
          padding: EdgeInsets.all(10.0),
          child: Icon(icon,size: 38,color: UniversalVariables.greyColor,),

        ),
        subtitle: Text(subtitle,style: TextStyle(
          color: UniversalVariables.greyColor,
          fontSize: 14
        ),),
        title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
