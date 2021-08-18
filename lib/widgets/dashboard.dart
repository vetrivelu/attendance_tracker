import 'package:attendance_tracker/models/personModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Dashboard extends StatelessWidget {
  Dashboard({Key key, this.person}) : super(key: key);
  final PersonModel person ;

  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return SfCircularChart(
   title: ChartTitle(text: 'Attendance'),
   legend: Legend(isVisible: true),
   series: <PieSeries<PieData, String>>[
     PieSeries<PieData, String>(
       explode: true,
       explodeIndex: 0,
       dataSource: person.getYearlyDataSet(),
       xValueMapper: (PieData data, _) => data.xData,
       yValueMapper: (PieData data, _) => data.yData,
       dataLabelMapper: (PieData data, _) => data.text,
       dataLabelSettings: DataLabelSettings(isVisible: true)),
   ]
  );
  }
  
}

