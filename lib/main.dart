import 'package:flutter/material.dart';
import 'package:internship/pages/homescreen.dart';
import 'package:internship/pages/splash.dart';

import 'pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
//      darkTheme: ThemeData.dark(
//
//
//      ),
      theme: ThemeData(

        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Material(child: SplashScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: HomeScreen()
      ),

    );
  }
}
