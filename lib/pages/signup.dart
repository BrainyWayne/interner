import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship/pages/homepage.dart';
import 'package:internship/pages/homescreen.dart';
import 'package:internship/pages/profile.dart';
import 'package:internship/services/firebase_auth.dart';
import 'package:internship/util/fadeanimations.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

String email;
String password;
bool loggingIn = false;
String signUpButtonText = "Sign Up";
FirebaseUser user;
File _image;
String _uploadedFileURL = "null";
var imageURL;
String username;

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: AssetImage('assets/images/background.png'),
//                          fit: BoxFit.fill
//                      )
                      ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    chooseFile();
                                  },
                                  child: Container(
                                      child: _uploadedFileURL == "null"
                                          ? CircleAvatar(
                                              child: Icon(
                                                Icons.account_circle,
                                                color: Colors.white,
                                                size: 60,
                                              ),
                                              radius: 60,
                                              backgroundColor: Colors.green,
                                            )
                                          : ClipRRect(

                                        borderRadius: BorderRadius.circular(40),
                                              child: Image.file(_image))),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    onChanged: (val) {
                                      username = val;
                                      print("Username: " + username);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    onChanged: (val) {
                                      email = val;
                                      print(email);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (val) {
                                      password = val;
                                      print(password);
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          InkWell(
                            onTap: () {
                              setState(() {
                                loggingIn = true;
                                signUpButtonText = "Signing Up ...";
                              });
                              try {
                                Auth _auth = Auth();
                                _auth
                                    .signUp(email, password)
                                    .then((onValue) async {
                                  _auth.sendEmailVerification();

                                  user =
                                      await FirebaseAuth.instance.currentUser();

                                  await uploadFile();
                                  //Uploading information to firestore
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .updateData({
                                        "email": email,
                                        "userid": user.uid,
                                        "name": username,
                                        "photo": imageURL.toString(),
                                      })
                                      .then((result) => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomeScreen()))
                                          })
                                      .catchError((err) => print(err));

                                  if (onValue != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomeScreen()));
                                  }

                                  if (onValue
                                      .toString()
                                      .contains("ERROR_INVALID_EMAIL")) {}
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Visibility(
                                      visible: loggingIn,
                                      child: SpinKitChasingDots(
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      signUpButtonText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        _uploadedFileURL = image.toString();
      });
    });
  }

  Future uploadFile() async {
    user = await FirebaseAuth.instance.currentUser();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/' + user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print(' Uploaded');
    await storageReference.getDownloadURL().then((photoURL) {
      print("photoURL: " + photoURL);
      imageURL = photoURL;
      print("imageURL: " + imageURL);
      Firestore.instance.collection('users').document(user.uid).updateData({
        "photo": imageURL.toString(),
      });
    });
  }
}
