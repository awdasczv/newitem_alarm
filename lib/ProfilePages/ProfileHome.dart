import 'package:flutter/material.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          title: Text("My Page"),
        ),*/
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("My Page",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
              ),
              Container(
                  color: Colors.blue,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white60,
                          backgroundImage: AssetImage('assets/images/profile3.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left),
                          Text("Date",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left)
                        ],
                      )

                    ],
                  )

                /*child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/profile.png'),
                      ),
                    )*/
              ),
               /*Expanded(
                   child: Container(
                       child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text("Name"),
                             Text("date")
                           ]
                       )
                   )
            ]
        ))*/
            ]
        )
    );
  }
}
