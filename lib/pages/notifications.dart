import 'package:flutter/material.dart';
import 'package:internship/util/colors.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40,),
            Text("NOTIFICATIONS", style: TextStyle(color: normalTextColor, fontSize: 23, fontFamily: "Horizon"),),
            SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
