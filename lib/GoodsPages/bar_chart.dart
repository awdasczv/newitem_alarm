import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class ProductReview extends StatelessWidget {

  String Sum()
  {
    double score5 = 0, score4 = 0, score3 = 0, score2 = 0, score1 = 0, sum = 0, avg = 0, count = 0;
    for(int i = 0; i < bardata.length; i++)
    {
      score5 = 5 * bardata[0].jumlah;
      score4 = 4 * bardata[1].jumlah;
      score3 = 3 * bardata[2].jumlah;
      score2 = 2 * bardata[3].jumlah;
      score1 = 1 * bardata[4].jumlah;
      count += bardata[i].jumlah;
      sum = score1 + score2 + score3 + score4 + score5;
      avg = sum / count;
    }
    return avg.toStringAsFixed(1);
  }

  List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "5.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: 179,
      tooltip: "",
    ),
    VBarChartModel(
      index: 1,
      label: "4.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: 123,
      tooltip: "",
    ),
    VBarChartModel(
      index: 2,
      label: "3.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: 121,
      tooltip: "",
    ),
    VBarChartModel(
      index: 3,
      label: "2.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: 4,
      tooltip: "",
    ),
    VBarChartModel(
      index: 4,
      label: "1.0",
      colors: [Color(0xffFFC845), Color(0xffFFC845)],
      jumlah: 7,
      tooltip: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {


    List<VBarChartModel> barcolor = [
      VBarChartModel(
        index: 0,
        label: "",
        colors: [Colors.grey, Colors.grey],
        jumlah: 400,
        tooltip: "179개",
      ),
      VBarChartModel(
        index: 1,
        label: "",
        colors: [Colors.grey, Colors.grey],
        jumlah: 400,
        tooltip: "123개",
      ),
      VBarChartModel(
        index: 2,
        label: "",
        colors: [Colors.grey, Colors.grey],
        jumlah: 400,
        tooltip: "121개",
      ),
      VBarChartModel(
        index: 3,
        label: "",
        colors: [Colors.grey, Colors.grey],
        jumlah: 400,
        tooltip: "4개",
      ),
      VBarChartModel(
        index: 4,
        label: "",
        colors: [Colors.grey, Colors.grey],
        jumlah: 400,
        tooltip: "7개",
      ),

    ];

    // 평점 계산

    //////////////////////////////////////////////////
    return Container(
      width: 200,
      height: 500,
      //resizeToAvoidBottomInset: false,
      //color: Colors.blue,
      //child: Text('${avg.toStringAsFixed(1)}'),   // 평점 계산
      child: Container(
        width: 200,
        height: 130,
        child: _buildGrafik(bardata, barcolor),
      ),
    );
  }



  Widget _buildGrafik(List<VBarChartModel> bardata, barcolor) {
    return Stack(
        children: [
          VerticalBarchart(
            background: Colors.transparent,
            labelColor: Colors.grey,
            tooltipColor: Colors.grey,
            maxX: 400,
            data: barcolor,
            barStyle: BarStyle.DEFAULT,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 4,
            child: VerticalBarchart(
              background: Colors.transparent,
              labelColor: Color(0xff283137),
              tooltipColor: Color(0xff8e97a0),
              maxX: 400,
              data: bardata,
              barStyle: BarStyle.DEFAULT,
            ),
          )
        ],
    );
  }

  /*
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
  */
}