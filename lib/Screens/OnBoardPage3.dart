import 'package:chall/Globals/constants.dart';

import 'package:flutter/material.dart';

import 'justChoice.dart';


class OnBoardThree extends StatefulWidget {
  @override
  _OnBoardThreeState createState() => _OnBoardThreeState();
}

class _OnBoardThreeState extends State<OnBoardThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 280.0,
              height: 280.0,
              child: Image.asset('assets/logo.png')
          ),
          SizedBox(
            height: 315.0,
          ),
          Center(
            child: MaterialButton(

              splashColor: Colors.transparent,
              minWidth: 150.0,
              height: 50.0,
              color: Colors.grey[800],
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> RenderChoice()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ],

      ),

    );
  }
}
