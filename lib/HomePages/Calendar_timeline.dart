import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final ItemScrollController yearController = ItemScrollController();
  final ItemScrollController monthController = ItemScrollController();

  List month_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int selected_year_index = 1;
  int current_year = DateTime.now().year.toInt();
  int current_month = DateTime.now().month.toInt();
  int selected_month_index = DateTime.now().month.toInt() - 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [buildYear(), buildMonth()],
    );
  }

  Widget buildYear() {
    List year_list = [current_year - 1, current_year, current_year + 1];
    return SizedBox(
      height: 30,
      child: ScrollablePositionedList.builder(
          padding: EdgeInsets.symmetric(horizontal: 80),
          //이렇게 중앙에 두는 게 맞는 것인지.. 왜 Center를 쓸 때 안되는 것인지..
          initialScrollIndex: selected_year_index,
          scrollDirection: Axis.horizontal,
          itemScrollController: yearController,
          itemCount: year_list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected_year_index = index;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isSelectedYear(
                      isSelected: selected_year_index == index,
                      year: year_list[index],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget buildMonth() {
    return SizedBox(
      height: 70,
      child: ScrollablePositionedList.builder(
          padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
          itemCount: month_list.length,
          itemScrollController: monthController,
          initialScrollIndex: selected_month_index,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected_month_index = index;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isSelectedMonth(
                    isSelected: selected_month_index == index,
                    month: month_list[index],
                  )
                ],
              ),
            );
          }),
    );
  }
}

class isSelectedYear extends StatelessWidget {
  final bool isSelected;
  final int year;

  isSelectedYear({this.isSelected = false, this.year});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${year}년'.toUpperCase(),
      style: TextStyle(
          fontSize: this.isSelected ? 24 : 16,
          color: this.isSelected ? Colors.black : Colors.black38,
          fontWeight: this.isSelected ? FontWeight.bold : FontWeight.normal),
    );
  }
}

class isSelectedMonth extends StatelessWidget {
  final bool isSelected;
  final int month;

  isSelectedMonth({this.isSelected = false, this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: isSelected
            ? BoxDecoration(color: Color(0xfff1c40f), shape: BoxShape.circle)
            : BoxDecoration(color: Colors.transparent),
        width: 53,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '${month}월'.toUpperCase(),
            style: isSelected
                ? TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 0.7)
                : TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 20, height: 0.7),
          ),
        ));
  }
}
