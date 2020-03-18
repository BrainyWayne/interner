import 'package:flutter/material.dart';
import 'package:internship/util/colors.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
        color: Colors.white.withOpacity(0.7),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40,),
            Text("FAVORITES", style: TextStyle(color: normalTextColor, fontSize: 23, fontFamily: "Horizon"),),
            SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
