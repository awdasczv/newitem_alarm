import 'package:flutter/material.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          title: Text("My Page"),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.blue,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/profile3.png'),
                      ),
                      Text("Name")
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
               )*/
            ]
        )
    );
  }
}
