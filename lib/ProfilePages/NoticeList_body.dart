import 'package:flutter/material.dart';


class NoticeList_body extends StatefulWidget {
  @override
  _NoticeList_bodyState createState() => _NoticeList_bodyState();
}

class _NoticeList_bodyState extends State<NoticeList_body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 800,
        height: 800,
        child: Column(
          children: [
            SizedBox(
              width: 800,
              height: 800,
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                color: Colors.white,
                child: Text("보안패치 12.0.0 업데이트 완료",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0, fontWeight: FontWeight.bold,)
                ),
              ),
            ),
          ],

      ),
      )

    );
  }
}