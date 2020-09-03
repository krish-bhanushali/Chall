
import 'package:chall/Globals/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class OnBoardPage2 extends StatefulWidget {
  @override
  _OnBoardPage2State createState() => _OnBoardPage2State();
}

class _OnBoardPage2State extends State<OnBoardPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 280.0,
              height: 280.0,
              child: Lottie.asset('assets/socialmedianetwork.json', alignment: Alignment.center)
          ),
          SizedBox(
            height: 115.0,
          ),
          Text(
            'Video call ? Or Conference ',
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
            'We have a solution for you',
            style: TextStyle(
              color: kWhiteColor.withOpacity(0.8),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Connecting is as easy as just saying Chall in real life',
            style: TextStyle(
              color: kWhiteColor.withOpacity(0.5),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],

      ),

    );
  }
}
