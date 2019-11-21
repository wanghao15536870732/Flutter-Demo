
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
          new Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0,left: 10.0),
            child:  Row(
              children: <Widget>[
                Text(
                  calendardata.yearTips +
                      calendardata.chineseZodliaz + '年  ' +
                      calendardata.lunarCalendar + '  ' +
                      calendardata.solarTerms,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.orangeAccent,
                  ),
                )
              ],
            ),
          ),

         new Container(
           color: Colors.grey[200],
           margin: EdgeInsets.only(top: 10.0,right: 5.0,left: 5.0),
           child: new Row(
             children: <Widget>[
               Container(
                 width: 400.0,
                 child: Text(
                   '宜：' + calendardata.suit,
                   style: TextStyle(
                     fontSize: 16.0,
                     color: Colors.black54,
                   ),
                 ),
               )
             ],
           ),
         ),
          new Container(
            color: Colors.grey[200],
            margin: EdgeInsets.only(right: 5.0,left: 5.0,bottom: 15.0),
            child: new Row(
              children: <Widget>[
                Container(
                  width: 320.0,
                  child: Text(
                    '忌：'+ calendardata.avoid,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          )
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