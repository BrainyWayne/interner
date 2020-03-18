import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internship/pages/homescreen.dart';
import 'package:internship/services/firebase_auth.dart';


import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

double pulseValue;
double pulseValueGrey;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      checkUser();
    });

    pulseIn();

    super.initState();
  }



  void pulseIn() {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        setState(() {
          pulseValue = 450;
          pulseValueGrey = 160;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset("assets/logowhite.png", fit: BoxFit.cover))),
            Container(
              color: Colors.white.withOpacity(1),
            ),
            Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                height: pulseValue,
                width: pulseValue,
                child: Image.asset(
                  "assets/logowhite.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUser() {
    Auth _auth = new Auth();
    _auth.getCurrentUser().then((onValue) {
      if (onValue != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
        );
      }
    });
  }
}
