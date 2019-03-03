
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_lake/FlutterWeather/data/WeekData.dart';

class PointsLineChart extends StatelessWidget {

  final List<charts.Series> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});


  factory PointsLineChart.withSampleData(WeekData data) {
    return new PointsLineChart(
      _createSampleData(data),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
        seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData(WeekData datas) {
    final data = [
      new LinearSales(0, int.parse(datas.htempture[0]), int.parse(datas.ltempture[0])),
      new LinearSales(1, int.parse(datas.htempture[1]), int.parse(datas.ltempture[1])),
      new LinearSales(2, int.parse(datas.htempture[2]), int.parse(datas.ltempture[2])),
      new LinearSales(3, int.parse(datas.htempture[3]), int.parse(datas.ltempture[3])),
      new LinearSales(4, int.parse(datas.htempture[4]), int.parse(datas.ltempture[4])),
      new LinearSales(5, int.parse(datas.htempture[5]), int.parse(datas.ltempture[5])),
      new LinearSales(6, int.parse(datas.htempture[6]), int.parse(datas.ltempture[6])),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales1',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Sales2',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales2,
        data: data,
      ),
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;
  final int sales2;
  LinearSales(this.year, this.sales,this.sales2);
}