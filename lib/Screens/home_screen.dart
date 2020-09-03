
import 'package:chall/Globals/constants.dart';
import 'package:chall/Screens/OnBoardPage1.dart';
import 'package:chall/Screens/OnBoardPage2.dart';
import 'package:flutter/material.dart';

import 'OnBoardPage3.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 //Page Controller
  PageController _pageController;

  // keeping track of current page
  int _currentPage = 0;

  // isDarkTheme or not
  bool _iseDarkTheme = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      keepPage: true,

    )..addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
      });
    });
  }

  @override
  void dispose() {
    // disposing the controller when
    // not in use
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _iseDarkTheme ? kDarkBackgroundColor : kLightBackgroundColor,
      body: SafeArea(
          top: false,
          bottom: true,
          left: true,
          right: true,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:
              PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context , index ){
              return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context , child){
                  //Just for animated lottie files
                  // multiplying factor for size
                    double value = 1.0;
                    // calculating the value
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page - index;
                      value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
                    } else {
                      value = index == 0 ? value : value * 0.8;
                    }
                    // return first page if index is 0
                    if (index == 0) {
                         return OnBoardOne();
                    }
                    // return second page if index is 1
                    else if (index == 1) {
                      return  OnBoardPage2();
                    }
                    // return third page otherwise
                    return  OnBoardThree();

                  });
            },

         )
              ),
              _PageIndicator(
                currentPage: _currentPage,
                isDarkTheme: _iseDarkTheme,
              ),
            ],
          )),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  // index of current page
  final int currentPage;
  // is dark theme
  final bool isDarkTheme;

  const _PageIndicator({
    Key key,
    @required this.currentPage,
    @required this.isDarkTheme,
  }) : super(key: key);

  // get color for dot
  Color _getDotColor(int index) {
    if (!isDarkTheme) {
      return currentPage == index
          ? kDarkTextColor.withOpacity(0.9)
          : kDarkTextColor.withOpacity(0.3);
    }

    return currentPage == index
        ? kWhiteColor.withOpacity(0.9)
        : kWhiteColor.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      height: 6.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: _getDotColor(0),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: _getDotColor(1),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: _getDotColor(2),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
