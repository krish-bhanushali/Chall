


import 'package:chall/Globals/constants.dart';
import 'package:chall/Providerr/user_provider.dart';
import 'package:chall/Screens/PageViews/pickup/pickup_layout.dart';
import 'package:chall/Screens/PageViews/pickup/pickup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'PageViews/chatListScreen.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController;
  int _page = 0;

  UserProvider userProvider;
  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }
  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
    pageController = PageController(

    );
  }
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: PageView(
          children: [
            Container(child: ChatListScreen(),),
            Center(child: Text('Call Log Screen'),),
            Center(child: Text('Contact Screen'),),

          ],
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
          child: CupertinoTabBar(
              backgroundColor: UniversalVariables.blackColor,
              items: [
                BottomNavigationBarItem(
                  title: Text('Chats', style: TextStyle(
                    fontSize: 10,
                    color: _page == 0 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor
                  ),),
                  icon: Icon(Icons.chat , color: _page == 0 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor,),
                ),
                BottomNavigationBarItem(
                  title: Text('Calls', style: TextStyle(
                      fontSize: 10,
                      color: _page == 1 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor
                  ),),
                  icon: Icon(Icons.call , color: _page == 1 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor,),
                ),
                BottomNavigationBarItem(
                  title: Text('Contacts', style: TextStyle(
                      fontSize: 10,
                      color: _page == 2 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor
                  ),),
                  icon: Icon(Icons.contact_phone , color: _page == 2 ? UniversalVariables.lightBlueColor : UniversalVariables.greyColor,),
                ),

              ],
          onTap: navigationTapped,
          currentIndex: _page,

          ),
          ),
        ),
      ),
    );
  }
}
