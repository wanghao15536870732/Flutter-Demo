
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterWeather/data/CalendarData.dart';
import 'package:http/http.dart' as http;

class CalendarWidget extends StatefulWidget{

  String data;

  CalendarWidget(this.data);

  @override
  State<StatefulWidget> createState() {
    return new CalendarState(data);
  }
}

class CalendarState extends State<CalendarWidget>{
  
  String date;
  
  CalendarData calendardata = CalendarData.empty();
  
  CalendarState(String date){
    this.date = date;
    _getDate();
  }
  
  void _getDate() async{
    CalendarData data = await _fetchData();
    setState(() {
      calendardata = data;
    });
  }
  
  Future<CalendarData> _fetchData() async{
    print(date.toString());
    final response = await http.get('http://www.mxnzp.com/api/holiday/single/'+ date) ;
    if(response.statusCode == 200){
      return CalendarData.fromJson(json.decode(response.body));
    }else{
      return CalendarData.empty();
    }
  }

  Widget buildBody(){
    if(calendardata != null && calendardata.code == 1 ){
      return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                calendardata.date.substring(0,4) + '年' + calendardata.date.substring(6,7)  + '月' +calendardata.date.substring(9,10) + '日'  ,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                calendardata.lunarCalendar,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                calendardata.solarTerms,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                calendardata.yearTips + calendardata.chineseZodliaz + '年',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 380.0,
                child: Text(
                  calendardata.avoid,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 280.0,
                child: Text(
                  calendardata.suit,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }else{
      return new Center(
        child: Text('数据正在加载中...'),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('万年历'),
      ),
      body: new Container(
        child: buildBody(),
      )
    );
  }
}