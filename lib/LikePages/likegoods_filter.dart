import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsFilter extends StatefulWidget {
  @override
  _GoodsFilterState createState() => _GoodsFilterState();
}

class _GoodsFilterState extends State<GoodsFilter> {
  String _default = "신상품순"; //상품필터 default로 신상품순이 보임.
  List _filterOptions = ['신상품순', '인기순'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // PopMenuButton 누르면 list의 버튼들 중 선택할 수 있는 것,비슷한 걸로 DropdownButton 있음)
        // DropdownButton과 달리 누르면 선택한 list item이 표시되지는 않음.
        padding: EdgeInsets.zero,
        offset: Offset(0, 0),
        icon: Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$_default',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ), //언젠가 TextStyle을 그냥 통일해서 하나를 계속 사용하면 편할 듯 싶음.
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.black,
                ),
              ],
            ),
            onPressed: null,
          ),
        ),
        onSelected: (item) {
          setState(() {
            _default = item.toString();
          });
        },
        itemBuilder: (BuildContext context) {
          return _filterOptions.map((option) {
            return PopupMenuItem(
              child: Text(
                "$option",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              value: option,
            );
          }).toList();
        });
  }
}
