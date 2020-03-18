import 'package:flutter/material.dart';
import 'package:internship/pages/wholepagedetail.dart';
import 'package:internship/util/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 60),
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 26, bottom: 15),
            child: Row(
              children: <Widget>[
                Text(
                  "Developers",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Avenue",
                  style: TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Hero(
              tag: "featuredtag",
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WholePageDetail(),
                    ),
                  );
                },
                child: Card(
                  elevation: 25,
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
                                  Text(
                                    "Featured",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Kickstart your \nCareer",
                                    style: TextStyle(
                                        color: normalTextColor, fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 60,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Internships",
                                        style: TextStyle(
                                            color: normalTextColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Learn the real world experience",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      "View more",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      color: Colors.red,
                    ),
                    Container(
                      height: 60,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//  List _buildList() {
//    List<Widget> listItems = List();
//
//    for (int i = 0; i < count; i++) {
//      listItems.add(new Padding(
//          padding: new EdgeInsets.all(20.0),
//          child: new Text('Item ${i.toString()}',
//              style: new TextStyle(fontSize: 25.0))));
//    }
//
//    return listItems;
//  }
}
