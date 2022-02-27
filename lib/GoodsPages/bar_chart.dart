import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class ProductReview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<VBarChartModel> bardata = [
      VBarChartModel(
        index: 0,
        label: "5.0",
        colors: [Color(0xffFFC845), Color(0xffFFC845)],
        jumlah: 179,
        tooltip: "179개",
      ),
      VBarChartModel(
        index: 1,
        label: "4.0",
        colors: [Color(0xffFFC845), Color(0xffFFC845)],
        jumlah: 123,
        tooltip: "123개",
      ),
      VBarChartModel(
        index: 2,
        label: "3.0",
        colors: [Color(0xffFFC845), Color(0xffFFC845)],
        jumlah: 121,
        tooltip: "121개",
      ),
      VBarChartModel(
        index: 3,
        label: "2.0",
        colors: [Color(0xffFFC845), Color(0xffFFC845)],
        jumlah: 4,
        tooltip: "4개",
      ),
      VBarChartModel(
        index: 4,
        label: "1.0",
        colors: [Color(0xffFFC845), Color(0xffFFC845)],
        jumlah: 7,
        tooltip: "7개",
      ),
    ];
    return Container(
      width: 200,
      height: 500,
      //resizeToAvoidBottomInset: false,
      //color: Colors.blue,
      child: Container(
        width: 200,
        height: 130,
        child: _buildGrafik(bardata),
      ),
    );
  }

  Widget _buildGrafik(List<VBarChartModel> bardata) {
    return VerticalBarchart(
      background: Colors.transparent,
      labelColor: Color(0xff283137),
      tooltipColor: Color(0xff8e97a0),
      maxX: 400,
      data: bardata,
      barStyle: BarStyle.DEFAULT,
    );
  }
}