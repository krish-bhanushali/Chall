import 'package:chall/Globals/constants.dart';
import 'package:chall/Screens/PageViews/chatListScreen.dart';
import 'package:chall/Widgets/customtile.dart';
import 'package:chall/models/user.dart';
import 'package:chall/resources/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'chatscreens/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  List<UserClass> userList;
  String query = "";
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseRepository.getUserCurrentlyFutureMethod().then((currentUser) {
       _firebaseRepository.fetchAllUsers(currentUser).then((List<UserClass> list) {
         setState(() {
           userList = list;
         });
       });
    });
  }
  searchAppBar(BuildContext context){
     return GradientAppBar(
       gradient: LinearGradient(colors: [UniversalVariables.gradientColorStart,UniversalVariables.gradientColorEnd]),
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.white,),
         onPressed: ()=> Navigator.pop(context),

       ),
       elevation: 0,
       bottom: PreferredSize(child: Padding(padding: EdgeInsets.only(left: 20),
       child: TextField(
            controller: _textEditingController,
            onChanged: (val){
              setState(() {
                query = val;
              });
            },
           cursorColor: UniversalVariables.blackColor,
         autofocus: true,
         style: TextStyle(
           fontSize: 35,
           fontWeight: FontWeight.bold,
           color: Colors.white
         ),
         decoration: InputDecoration(
           suffix: IconButton(
             icon: Icon(
               Icons.close,
               color: Colors.white,
             ),
             onPressed: (){
               _textEditingController.clear();
             },

           ),
           border: InputBorder.none,
           hintText: "Search",
           hintStyle: TextStyle(
               fontSize: 35,
               fontWeight: FontWeight.bold,
               color: Color(0x88ffffff),

           )

         ),
       ),
       ), preferredSize: const Size.fromHeight(kToolbarHeight + 20)),
     );
  }
  buildSuggestions(String query){
    print(userList);
    print(query);
    final List<UserClass> suggestionList = query.isEmpty ? [] : userList.where(
        (UserClass user)
         {
           print(user.username);
           print(user.name);
           print(user.profilePhoto);
           var _getUsername = user.username.toLowerCase();
           var _getName = user.name.toLowerCase();
           var _getQuery = query.toLowerCase();
           var matchUsername = _getUsername.contains(_getQuery);
           var matchName = _getName.contains(_getQuery);
           return (matchName || matchUsername);

           
           //((user.username.toLowerCase().contains(query.toLowerCase())) || (user.name.toLowerCase().contains(query.toLowerCase())))
         }
        

    ).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index){
          UserClass searchedUser = UserClass(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username
          );
          return CustomTile(
            mini: false,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => ChatScreen(
                  receiver : searchedUser
                )
              ));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(searchedUser.profilePhoto)
              ,
              backgroundColor: Colors.grey,


            ),
            title: Text(
              searchedUser.username,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,

              ),

            ),
            subtitle: Text(
              searchedUser.name,
              style: TextStyle(
                color: Colors.grey,


              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }
}
