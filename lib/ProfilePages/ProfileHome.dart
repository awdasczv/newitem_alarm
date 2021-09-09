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
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 400, top: 20, bottom: 20),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/profile.png'),
                      ),
                    )
                ),
              ),
              // Expanded(
              //     child: Container(
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: <Widget>[
              //               Text("Name"),
              //               Text("date")
              //             ]
              //         )
              //     )
              // )
            ]
        )
    );
  }
}
