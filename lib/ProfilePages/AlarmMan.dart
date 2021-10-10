import 'package:flutter/material.dart';

class AlarmMan extends StatefulWidget {
  const AlarmMan({Key key}) : super(key: key);

  @override
  _AlarmManState createState() => _AlarmManState();
}

class _AlarmManState extends State<AlarmMan> {

  List<String> _alarm = [
    "댓글11111111111111111111111111111111111111",
    "댓글22222222222222222222222222222222222222222222222",
    "댓글3333333333333333333333333333333333333",
    "댓글44444444444444444444444444444444444444444444444444444",
    "댓글5555555555555555555555555555555"
  ];

  List<bool> _alarmSwitch = [];
  bool _allAlarmSwitch = false;

  void initState() {
    super.initState();
    _alarmSwitch = List<bool>.filled(_alarm.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("알림 설정",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("전체 선택"),
                    Switch(
                      value: _allAlarmSwitch,
                      onChanged: (value) {
                        setState(() {
                          _allAlarmSwitch = value;
                          _AllSwitchCheck();
                        });
                      },
                    )

                  ],
                )
            ),
            Container(
                child: Expanded(
                  child: _AlarmList(),
                )
            )
          ],
        )
    );
  }
  Widget _AlarmList() {
    return ListView.builder(
      itemCount: _alarm.length,
      itemBuilder: (context, index) {
        final item = _alarm[index];
        return SwitchListTile(
          title: Text(item),
          value: _alarmSwitch[index],
          onChanged: (value) {
            setState(() {
              _alarmSwitch[index] = value;
              //Navigator.pop(context, [_alarmSwitch]);
            });
          },
        );
      },
    );
  }
  Widget _AllSwitchCheck() {
    setState(() {
      if(_allAlarmSwitch == true) {
        _alarmSwitch = List<bool>.filled(_alarm.length, true);
      }
      else {
        _alarmSwitch = List<bool>.filled(_alarm.length, false);
      }
    });
  }
}