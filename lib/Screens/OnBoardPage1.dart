
import 'package:chall/Globals/constants.dart';
import 'package:flutter/material.dart';

class OnBoardOne extends StatefulWidget {
  @override
  _OnBoardOneState createState() => _OnBoardOneState();
}

class _OnBoardOneState extends State<OnBoardOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
//          Container(
//            width: 280.0,
//            height: 280.0,
//            child: Lottie.asset('assets/socialmedianetwork.json', alignment: Alignment.center)
//          ),
          SizedBox(
            height: 115.0,
          ),
          Text(
            'Say Chall!',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            'Let\'s have a virtual cup of Chai',
            style: TextStyle(
              color: kWhiteColor.withOpacity(0.8),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            'Connecting is as easy as just saying Chall in real life',
            style: TextStyle(
              color: kWhiteColor.withOpacity(0.8),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],

      ),

    );
  }
}

