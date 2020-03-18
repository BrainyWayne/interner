import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/pages/splash.dart';
import 'package:internship/services/firebase_auth.dart';
import 'package:internship/util/colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

String username;
String email;
String photoUrl;


class _ProfileState extends State<Profile> {

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40,),
            Text("PROFILE", style: TextStyle(color: normalTextColor, fontSize: 23, fontFamily: "Horizon"),),
            SizedBox(height: 30,),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(105),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: CachedNetworkImage(imageUrl: photoUrl, fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(username, style: TextStyle(fontWeight: FontWeight.bold, color: normalTextColor, fontSize: 18),),
                    Text("eshunfrancisboateng@gmail.com")
                  ],
                ),

              ],
            ),

            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[

                  InkWell(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Profile Settings", style: TextStyle(fontWeight: FontWeight.bold, color: normalTextColor),),
                            SizedBox(height: 5,),
                            Text(username)
                          ],
                        ),

                        Icon(Icons.arrow_forward_ios, size: 15,)
                      ],
                    ),
                    onTap: (){
                    },
                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Languages", style: TextStyle(fontWeight: FontWeight.bold, color: normalTextColor),),
                          SizedBox(height: 5,),
                          Text("English US")
                        ],
                      ),

                      Icon(Icons.arrow_forward_ios, size: 15,)
                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Email Notifications", style: TextStyle(fontWeight: FontWeight.bold, color: normalTextColor),),
                          SizedBox(height: 5,),
                          Text("On")
                        ],
                      ),

                      Icon(Icons.arrow_forward_ios, size: 15,)
                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Push Notifications", style: TextStyle(fontWeight: FontWeight.bold, color: normalTextColor),),
                          SizedBox(height: 5,),
                          Text("Off")
                        ],
                      ),

                      Icon(Icons.arrow_forward_ios, size: 15,)
                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Auth auth = new Auth();
                          auth.signOut().then((onValue){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),

                          ],
                        ),
                      ),


                    ],
                  ),

                  SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
    Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        var photolink;
        try {
          photolink = datasnapshot.data['photo'].toString();
        } catch (e) {
          photoUrl = "N/A";
        }

        setState(() {
          username = datasnapshot.data['name'].toString();
          email = datasnapshot.data['email'].toString();
          photoUrl = photolink;

        });
      }
    });
  }

}
