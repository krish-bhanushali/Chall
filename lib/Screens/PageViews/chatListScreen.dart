


import 'package:chall/Globals/constants.dart';
import 'package:chall/Screens/searchScreen.dart';
import 'package:chall/Widgets/Appbar.dart';
import 'package:chall/Widgets/customtile.dart';
import 'package:chall/resources/firebase_repository.dart';
import 'package:chall/utils/utilities.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final FirebaseRepository _firebaseRepository = FirebaseRepository();

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials = 'NA';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SEE THIS LATER
    _firebaseRepository.getUserCurrentlyFutureMethod().then((currentUser) {
      setState(() {
        currentUserId = currentUser.uid;

        MyUtils.getInitials(currentUser.displayName).then((value) => initials = value) ;
        print(initials);
      });
    });

  }

  CustomAppBar customAppBar(BuildContext context){
    return CustomAppBar(
      leading: IconButton(icon: Icon(Icons.notifications), onPressed: (){

      }),
      title: UserCircle(text: initials),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: (){
          //Use named routes later
         Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen()));
        }),
        IconButton(icon: Icon(Icons.more_vert), onPressed: (){

        })
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId: currentUserId,),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  const ChatListContainer({Key key, this.currentUserId}) : super(key: key);
  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(

          padding: EdgeInsets.all(10.0),
          itemCount: 2,
          itemBuilder: (context, index){
            return CustomTile(
              mini: false,
              onTap: (){

              },
              title: Text("Krish Bhanushali" , style: TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontSize: 19
              ),),
              subtitle: Text('Hello',style: TextStyle(
                color: UniversalVariables.greyColor,
                fontSize: 14
              ),),
              leading: Container(
                constraints: BoxConstraints(maxHeight: 60,maxWidth: 60),
                child: Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg"),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UniversalVariables.onlineDotColor,
                          border: Border.all(
                            color: UniversalVariables.blackColor,
                            width: 2
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UniversalVariables.fabGradient,
        shape: BoxShape.circle,
        
      ),
      child: Icon(Icons.edit,
        color: Colors.white,
        size: 25,
      
      
      ),
      padding: EdgeInsets.all(15),
    );
  }
}


class UserCircle extends StatelessWidget {
  final String text;

  const UserCircle({Key key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: UniversalVariables.lightBlueColor,
              fontSize: 13
            ),),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UniversalVariables.blackColor,
                  width: 2

                ),
                color: UniversalVariables.onlineDotColor
              ),
            ),
          )
        ],
      ),
    );
  }
}
