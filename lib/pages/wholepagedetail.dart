import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internship/util/colors.dart';
import 'dart:async';
class WholePageDetail extends StatefulWidget {
  @override
  _WholePageDetailState createState() => _WholePageDetailState();
}

Color imageCover = Colors.transparent;
class _WholePageDetailState extends State<WholePageDetail> {


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        imageCover = Colors.transparent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Hero(
                tag: "featuredtag",
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/subtle.png",
                            fit: BoxFit.cover,
                          ),
                        ),

                        AnimatedContainer(
                          height: 300,
                          duration: Duration(microseconds: 500),
                          curve: Curves.easeIn,
                          color: imageCover
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 300,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      InkWell(

                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 2, right: 15, left: 0),
                                          child: Platform.isIOS ? Icon(Icons.arrow_back_ios) : Icon(Icons.arrow_back),
                                        ),
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text(
                                        "Featured",
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.9), fontSize: 22),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Text(
                                    "Kickstart your \nCareer",
                                    style: TextStyle(
                                        color: normalTextColor, fontSize: 30),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],

    );
  }
}
