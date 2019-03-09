
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterWeather/chart/PointsLineChart.dart';
import 'package:flutter_demo/FlutterWeather/chart/TimeSeriesBar.dart';
import 'package:flutter_demo/FlutterWeather/data/WeekData.dart';
import 'package:http/http.dart' as http;

class WeekWeather extends StatefulWidget{

  String cityName;
  WeekData weekData = WeekData.empty();

  WeekWeather(this.cityName,this.weekData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeekWeatherState(this.cityName,weekData);
  }
}

class WeekWeatherState extends State<WeekWeather> {

  String cityName;
  List<Widget> widgets = new List();
  WeekData weekData = WeekData.empty();

  WeekWeatherState(String cityName,WeekData wordata) {
    this.cityName = cityName;
    this.weekData = wordata;
  }

  Widget buildFutureItem(String data, String weatherImg, String weather,
      String temp, String windair, String windsc,String weatherImg_n,String weather_n) {
    return Container(
      height: 300.0,
      width: 115.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              data.substring(5,7) + '月' + data.substring(8,10) + '日',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Image.asset(
            weatherImg,
            width: 40.0,
            height: 40.0,
            fit: BoxFit.fill,
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              weather,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              temp,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              windair,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              windsc,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Image.asset(
              weatherImg_n,
              width: 40.0,
              height: 40.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new Text(
              weather_n,
              style: new TextStyle(
                fontSize: 16.0,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildWeekWeather() {
    return new Container(
      child: new Row(
        children: <Widget>[
          widgets[0],
          widgets[1],
          widgets[2],
          widgets[3],
          widgets[4],
          widgets[5],
          widgets[6],
        ],
      ),
    );
  }

  Widget rebuildWeekWeather(){
    for(int index = 0;index < weekData.data.length;index ++){
      widgets.add(
        buildFutureItem(
          weekData.data[index].toString(),
          'images/' + weekData.code[index].toString() + '.png',
          weekData.weather[index].toString(),
          weekData.ltempture[index].toString() + '℃ ' + '~' +
              weekData.htempture[index].toString() + ' ℃',
          weekData.winddir[index].toString(),
          weekData.windsc[index].toString() + '级',
          'images/' + weekData.code_n[index].toString() + '.png',
          weekData.weather_n[index].toString(),
        ),
      );
    }
    if(widgets.length > 0){
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Color(0x3399CCFF),
          child: Row(
            children: <Widget>[
              buildWeekWeather(),
            ],
          ),
        ),
      );
    }else{
      return new Container(
        width: double.infinity,
        height: double.infinity,
        child: new Text(
          '数据正在加载中,请稍等...',
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 16.0,
            color: Color(0xFF333333)
          ),
        ),
        margin: EdgeInsets.only(top: 10.0,)
      );
    }
  }

  Widget buildWeekText(String str){
    return Container(
      color: Colors.lightBlueAccent,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: new Text(
                str,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              )
          ),
        ],
      ),
    );
  }

  AlertDialog dialog = new AlertDialog(
    content:  new Container(
        height: 200.0,
        width: 600.0,
      ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('the coming week'),
        ),
        body: new Column(
          children: <Widget>[
            rebuildWeekWeather(),
            buildWeekText('未来一周天气'),
          ],
        )
    );
  }
}
