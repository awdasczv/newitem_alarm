import 'package:flutter/material.dart';

class AlarmMan extends StatefulWidget {
  const AlarmMan({Key key}) : super(key: key);

  @override
  _AlarmManState createState() => _AlarmManState();
}

class _AlarmManState extends State<AlarmMan> {

  List<String> _alarm = [
    "알림1",
    "알림2",
    "알림3",
    "알림4",
    "알림5"
  ];

  List<bool> _alarmSwitch = [];
  bool _allAlarmSwitch = true;

  void initState() {
    super.initState();
    _alarmSwitch = List<bool>.filled(_alarm.length, true);
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
            Padding(
              padding: EdgeInsets.all(10),
            ) ,
            /*Container(
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
            ),*/
            Container(
                child: Expanded(
                  child: _AlarmList(),
                )
            )
          ],
        )
    );
  }

  //스위치 체크
  Widget _AlarmList() {
    return ListView.separated(
      itemCount: _alarm.length,
      itemBuilder: (context, index) {
        final item = _alarm[index];
        return SwitchListTile(
          title: Text(item, style: TextStyle(fontSize: 25)),
          value: _alarmSwitch[index],
          onChanged: (value) {
            setState(() {
              _alarmSwitch[index] = value;
              /*if (!value) {
                _allAlarmSwitch = false;
              }*/

            });
          },
        );
      },

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  // 전체 선택 스위치 체크
  /*Widget _AllSwitchCheck() {
    setState(() {
      if(_allAlarmSwitch == true) {
        _alarmSwitch = List<bool>.filled(_alarm.length, true);
      }
      else {
        _alarmSwitch = List<bool>.filled(_alarm.length, false);
      }
    });
  }*/
}