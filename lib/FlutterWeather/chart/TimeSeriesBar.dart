
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_lake/FlutterWeather/data/WeekData.dart';

class TimeSeriesBar extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData(WeekData data) {
    return new TimeSeriesBar(
      _createSampleData(data),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      domainAxis: new charts.DateTimeAxisSpec(usingBarRenderer: true),
      defaultInteractions: false,
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }
  
  static List<charts.Series<TimeSeriesSales,DateTime>> _createSampleData(WeekData datas){

    int y = DateTime.now().year;
    int m = DateTime.now().month;
    int d = DateTime.now().day;
    final data = [
      new TimeSeriesSales(new DateTime(y,m,d),double.parse(datas.weather_rain[0])),
      new TimeSeriesSales(new DateTime(y,m,d + 1),double.parse(datas.weather_rain[1])),
      new TimeSeriesSales(new DateTime(y,m,d + 2),double.parse(datas.weather_rain[2])),
      new TimeSeriesSales(new DateTime(y,m,d + 3),double.parse(datas.weather_rain[3])),
      new TimeSeriesSales(new DateTime(y,m,d + 4),double.parse(datas.weather_rain[4])),
      new TimeSeriesSales(new DateTime(y,m,d + 5),double.parse(datas.weather_rain[5])),
      new TimeSeriesSales(new DateTime(y,m,d + 6),double.parse(datas.weather_rain[6])),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final double sales;
  TimeSeriesSales(this.time, this.sales);
}

class LinearSales {
  final int year;
  final int sales;
  final int sales2;
  LinearSales(this.year, this.sales,this.sales2);
}