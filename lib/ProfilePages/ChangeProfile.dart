import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


/*class ChangeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}*/
class ChangeProfile extends StatefulWidget {

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("프로필 변경",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'heoro',
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/profile3.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: 'Name',
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('완료'),
                          onPressed: () {},
                        )
                      ],
                    )
                  ]
              ),
            )
          ]
      ),
    );
  }
}

/*class ChangeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("프로필 변경",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'heoro',
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/profile3.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: 'Name',
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('완료'),
                        onPressed: () {},
                      )
                    ],
                  )
                ]
              ),
            )
          ]
      ),
    );
  }
}*/