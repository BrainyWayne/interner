import 'package:flutter/material.dart';
import 'package:internship/pages/favorites.dart';
import 'package:internship/pages/homepage.dart';
import 'package:internship/pages/profile.dart';

import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var bottonNavBarIconsSize;
//var mediaQueryWidth = 100;
//var mediaQueryHeight = 350.0;
//var navBarBottomMargin = 20.0;
 double mediaQueryHeight = 50.0;


class _HomeScreenState extends State<HomeScreen> {
  PageController _pageViewController = new PageController();

  @override
  Widget build(BuildContext homeContext) {


    var mediaQueryWidth = 100;

    var navBarBottomMargin = 20.0;

     void showBottomSheet(){
      setState(() {
        mediaQueryWidth = 00;
        mediaQueryHeight = MediaQuery.of(homeContext).size.height - 100;
        navBarBottomMargin = 0.0;
      });
    }

    void hideBottomSheet(){
      setState(() {
        mediaQueryWidth = 100;
        mediaQueryHeight = 50;
        navBarBottomMargin = 20.0;
      });
    }


    return Material(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Stack(
          children: <Widget>[

            Container(
              height: double.infinity,
           //   width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(
                "assets/coding.png",
                fit: BoxFit.cover,
              ),
            ),
            PageView(
              controller: _pageViewController,
              children: <Widget>[HomePage(), Favorites(), Notifications(),Profile()],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
              margin: EdgeInsets.only(bottom: navBarBottomMargin),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(navBarBottomMargin)),
                  elevation: 25,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: MediaQuery.of(context).size.width - mediaQueryWidth,
                    height: mediaQueryHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(navBarBottomMargin)),
                    child: Container(
                      height: 0,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _pageViewController.jumpToPage(0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _pageViewController.jumpToPage(1);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _pageViewController.jumpToPage(2);
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _pageViewController.jumpToPage(3);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}
