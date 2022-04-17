import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

Widget barChart(int num5, int num4,int num3,int num2,int num1){

  List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "5.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: num5.toDouble(),
      tooltip: "",
    ),
    VBarChartModel(
      index: 1,
      label: "4.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: num4.toDouble(),
      tooltip: "",
    ),
    VBarChartModel(
      index: 2,
      label: "3.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: num3.toDouble(),
      tooltip: "",
    ),
    VBarChartModel(
      index: 3,
      label: "2.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: num2.toDouble(),
      tooltip: "",
    ),
    VBarChartModel(
      index: 4,
      label: "1.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: num1.toDouble(),
      tooltip: "",
    ),
  ];

  // 회색 배경 그래프
  List<VBarChartModel> barcount = [
    VBarChartModel(
      index: 0,
      label: "",
      colors: [Colors.grey, Colors.grey],
      jumlah: 400,
      tooltip: num5.toString(),
    ),
    VBarChartModel(
      index: 1,
      label: "",
      colors: [Colors.grey, Colors.grey],
      jumlah: 400,
      tooltip: num4.toString(),
    ),
    VBarChartModel(
      index: 2,
      label: "",
      colors: [Colors.grey, Colors.grey],
      jumlah: 400,
      tooltip: num3.toString(),
    ),
    VBarChartModel(
      index: 3,
      label: "",
      colors: [Colors.grey, Colors.grey],
      jumlah: 400,
      tooltip: num2.toString(),
    ),
    VBarChartModel(
      index: 4,
      label: "",
      colors: [Colors.grey, Colors.grey],
      jumlah: 400,
      tooltip: num1.toString(),
    ),
  ];

  return Container(
    width: 200,
    height: 130,
    child: Stack(
      children: [
        VerticalBarchart(
          background: Colors.transparent,
          labelColor: Color(0xff283137),
          tooltipColor: Color(0xff8e97a0),
          maxX: 400,
          data: barcount,
          barStyle: BarStyle.DEFAULT,
        ),
        VerticalBarchart(
          background: Colors.transparent,
          labelColor: Color(0xff283137),
          tooltipColor: Color(0xff8e97a0),
          maxX: 400,
          data: bardata,
          barStyle: BarStyle.DEFAULT,
        ),
      ],
    ),
  );
}

