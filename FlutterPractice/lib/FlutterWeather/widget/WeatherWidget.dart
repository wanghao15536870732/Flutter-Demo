
import 'dart:convert';
import 'package:demoflutter/FlutterWeather/chart/PointsLineChart.dart';
import 'package:demoflutter/FlutterWeather/chart/TimeSeriesBar.dart';
import 'package:demoflutter/FlutterWeather/data/DressingData.dart';
import 'package:demoflutter/FlutterWeather/data/WeatherData.dart';
import 'package:demoflutter/FlutterWeather/data/WeekData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CalendarWidget.dart';
import 'WeekWeather.dart';

class WeatherWidget extends StatefulWidget{

  String cityName;

  WeatherWidget(this.cityName);

  @override
  State<StatefulWidget> createState() {
    return new WeatherState(this.cityName);
  }
}
class WeatherState extends State<WeatherWidget>{

  String cityName;
  //主要的天气
  WeatherData weather = WeatherData.empty();
  //天气指数
  DressingData weatherLife = DressingData.empty();
  //未来7天天气
  List<Widget> widgets = new List();
  WeekData weekData = WeekData.empty();

  //空气质量
  WeatherAir weatherAir = WeatherAir.empty();

  WeatherState(String cityName){
    this.cityName = cityName;
    _getWeather();
  }

  void _getWeather() async{
    WeatherData data = await _fetchWeather();
    DressingData dataLife = await _fetchWeatherLife();
    WeekData dataWeek = await _fetchWeekWeather();
    WeatherAir weatherair = await _fetchWeatherAir();
    setState((){
      weather = data;
      weatherLife = dataLife;
      this.weekData = dataWeek;
      weatherAir = weatherair;
    });
  }

  /**
   * 获取基本天气信息
   */
  Future<WeatherData> _fetchWeather() async{
    final response = await http.get(
        'https://free-api.heweather.com/s6/weather/now?location='+
            cityName +
            '&key=551f547c64b24816acfed8471215cd0e'
    );
    if(response.statusCode == 200){
      return WeatherData.fromJson(json.decode(response.body));
    }else{
      return WeatherData.empty();
    }
  }

  /**
   * 获取穿衣指数，穿衣建议等等
   */
  Future<DressingData> _fetchWeatherLife() async{
    final response = await http.get(
        'https://free-api.heweather.net/s6/weather/lifestyle?parameters&location=' +
            cityName +
            '&key=551f547c64b24816acfed8471215cd0e'
    );
    if(response.statusCode == 200){
      return DressingData.fromJson(json.decode(response.body));
    }else{
      return DressingData.empty();
    }
  }

  Future<WeekData> _fetchWeekWeather() async {
    final response = await http.get(
        'https://free-api.heweather.net/s6/weather/forecast?parameters&location=' +
            cityName +
            '&key=551f547c64b24816acfed8471215cd0e'
    );
    if (response.statusCode == 200) {
      return WeekData.fromJson(json.decode(response.body));
    } else {
      return WeekData.empty();
    }
  }

  Future<WeatherAir> _fetchWeatherAir() async {
    final response = await http.get(
        'https://free-api.heweather.net/s6/air/now?&location=' +
            cityName +
            '&key=551f547c64b24816acfed8471215cd0e'
    );
    if (response.statusCode == 200) {
      return WeatherAir.fromJson(json.decode(response.body));
    } else {
      return WeatherAir.empty();
    }
  }


  @override
  Widget build(BuildContext context) {

    Widget headerSection = Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/'+ weather?.code + '.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                new Text(
                  this.cityName,
                  style: new TextStyle(
                      fontSize: 24.0,
                      color: Color(0xFF707070)
                  ),
                ),
                new Text(
                  weather?.cond,
                  style: new TextStyle(
                      fontSize: 18.0, color: Color(0xFF707070)
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 80.0,
            height: 80.0,
          )
        ],
      ),
    );

    Widget tempSection = Center(
        child: new GestureDetector(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: FractionalOffset(0.5, 0.5),
                child: new Text(
                  weather.tmp,
                  style: new TextStyle(
                    fontSize: 120.0,
                    fontFamily: 'AdobeClean',
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset(0.7, 0.0),
                child: new Text(
                  '℃',
                  style: new TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF707070)
                  ),
                ),
              )
            ],
          ),
          onTap: (){
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context){
                      return new Scaffold(
                        appBar: new AppBar(
                          title:new Text('未来七天温度变化'),
                          elevation: 0.0,
                        ),
                        body: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 15.0),
                                  child: new Icon(
                                    Icons.format_color_text,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 15.0),
                                  child: new Text(
                                    '最高温度  ℃',
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 15.0),
                                  child: new Icon(
                                    Icons.format_color_text,
                                    color: Colors.green,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 15.0),
                                  child: new Text(
                                    '最低温度  ℃',
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              height: 200.0,
                              width: 600.0,
                              child: PointsLineChart.withSampleData(weekData),
                            ),
                          ],
                        ),
                      );
                    }
                )
            );
          },
        )
    );

    Widget detailSection = Container(
      child: Center(
        child: new Text(
          weather.time + ' 发布',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );

    Row buildWeatherItem(String icon,String text){
      return Row(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Image.asset(
              icon,
              width: 22.0,
              height: 22.0,
              fit: BoxFit.fill,
            ),
          ),
          new Text(
            text,
            style: new TextStyle(
                fontSize: 16.0
            ),
          ),
        ],
      );
    }

    Widget itemSection = Container(
      margin: EdgeInsets.only(top: 15.0,bottom: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildWeatherItem('images/weather_wind.png',weather.wind),
          buildWeatherItem('images/weather_hum.png',weather.hum),
          buildWeatherItem('images/weather_cloud.png','云量 ' + weather.cloud),
        ],
      ),
    );


    Widget itemSections = Container(
      margin: EdgeInsets.only(top: 15.0,bottom: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildWeatherItem('images/weatherAirB.png',weatherAir.weatheralty),
          buildWeatherItem('images/weatherAirg.png','AQI  ' + weatherAir.weatheraqi),
          buildWeatherItem('images/weather_pm2.5.png','  '+ weatherAir.weatherpmn),
        ],
      ),
    );

    Widget bottomSection = Column(
      children: <Widget>[
        itemSections,
        itemSection,
        Divider(
          height: 1.0,
          color: Colors.black,
        )
      ],
    );


    Widget middleSection = Container(
      child: Column(
        children: <Widget>[
          tempSection,
          detailSection
        ],
      ),
    );

    Widget buildDressItem(String icon,String text){
      return new Container(
        color: Color(0x3399CCFF),
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0,bottom: 10.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              icon,
              width: 30.0,
              height: 30.0,
              fit: BoxFit.fitWidth,
            ),
            Padding(padding: EdgeInsets.only(right: 10.0),),
            new Column(
              children: <Widget>[
                Container(
                  child: Text(text,
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF333333),
                    ),
                  ),
                  width: 320.0,
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget dressSection = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildDressItem('images/weatherComf.png', weatherLife.weatherDet),
          buildDressItem('images/weatherSug.png', weatherLife.weatherSug),
          buildDressItem('images/weatherFlu.png', weatherLife.weatherFlu),
          buildDressItem('images/weatherSpo.png', weatherLife.weatherSpo),
          buildDressItem('images/weatherTra.png', weatherLife.weatherTra),
          buildDressItem('images/weatherUv.png', weatherLife.weatherUv),
          buildDressItem('images/weatherCw.png', weatherLife.weatherCw),
          buildDressItem('images/weatherAir.png', weatherLife.weatherAir),
        ],
      ),
    );

    Widget buildFutureItem(String data, String weatherImg, String weather,
        String temp, String windair, String windsc) {
      String datas = data.substring(0,4)+ data.substring(5,7) + data.substring(8,10);
      return Container(
        height: 300.0,
        width: 115.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,  //主轴的对齐方式
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: new GestureDetector(
                 child: new OutlineButton(
                   child: new Text(
                     data.substring(5,7) + '月' + data.substring(8,10) + '日',
                     style: TextStyle(
                       color: Color(0xFF333333),
                     ),
                   ),
                   onPressed: null,
                   shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(30.0),
                   ),
                 ),
                  onTap: (){
                    Navigator.push( //相当于Android里面得Intent
                      context,
                      MaterialPageRoute(builder: (context) =>
                        CalendarWidget(datas)
                      ),
                    );
                  }
                )
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
            ]
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
          ),
        );
      }
      if(widgets.length > 0){
        return Container(
//          margin: EdgeInsets.only(top: 20.0),
            color: Color(0x3399CCFF),
            child: new Container(
              margin: EdgeInsets.only(top:20.0,bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widgets[0],
                  widgets[1],
                  widgets[2],
                ],
              ),
            )
        );
      }else{
        return new Container(
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

    Widget buildWeekWeather(){
      return Container(
        color: Colors.lightBlueAccent,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              child: new Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: new Text(
                    '未来7天天气趋势预报',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  )
              ),
              onTap: (){
                Navigator.push( //相当于Android里面得Intent
                  context,
                  MaterialPageRoute(builder: (context) => WeekWeather(cityName,weekData)),
                );
              },
            )
          ],
        ),
      );
    }

    Widget buildJsonFrom(){
      return Container(
        color: Colors.lightBlueAccent,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[new Container(
              margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: new Text(
                '气象数据来源 和风天气',
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

    Widget airItem(String num,String item){
      return Container(
        height: 50.0,
        width: 80.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              child: new Text(
                item,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF333333)
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              child: new Text(
                num,
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.lightGreen,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    AlertDialog dialog = new AlertDialog(
        content: new Container(
            color: Color(0x3399CCFF),
            child: new Container(
                height: 100.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        airItem(weatherAir.weatherpmn,'PM2.5'),
                        airItem(weatherAir.weatherpm10,'PM10'),
                        airItem(weatherAir.weatherSo2,'SO2'),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        airItem(weatherAir.weatheralty,'空气质量'),
                        airItem(weatherAir.weatheraqi,'AQI'),
                        airItem(weather.cloud,'云量'),
                      ],
                    ),
                  ],
                )
            )
        )
    );

    Row buildItem(String str,int count){
      return Row(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10.0,bottom: 5.0,left: 15.0),
            child: new Icon(
              Icons.invert_colors,
              color: Colors.blue[count],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0,bottom: 5.0,left: 15.0),
            child: new Text(
              str,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.blue[count],
              ),
            ),
          ),
        ],
      );
    }


    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Weather'),
          actions: <Widget>[
            new IconButton(
                icon: new Image.asset('images/weather_rain.png'),
                onPressed: (){
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context){
                            return new Scaffold(
                              appBar: new AppBar(
                                title:new Text('未来七天降水变化'),
                                elevation: 0.0,
                              ),
                              body: new Column(
                                children: <Widget>[
                                  buildItem('小雨  10mm以下',200),
                                  buildItem('中雨  10~24.9mm',400),
                                  buildItem('大雨  25~49.9mm',600),
                                  buildItem('暴雨  50~99.9mm',800),
                                  new Container(
                                    height: 230.0,
                                    width: 600.0,
                                    child: TimeSeriesBar.withSampleData(weekData),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                  );
                }
            ),
            new IconButton(
                icon: new Icon(Icons.near_me),
                onPressed: (){
                  showDialog(
                      context: context,
                      child: dialog
                  );
                }
            ),
          ],
        ),
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start, //垂直布局
                crossAxisAlignment: CrossAxisAlignment.center,  //水平布局
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    child: new Column(
                      children: <Widget>[
                        headerSection,
                        middleSection,
                        bottomSection,
                        rebuildWeekWeather(),
                        Divider(height: 1.0, color: Colors.black,),
                        buildWeekWeather(),
                        dressSection,
                        buildJsonFrom(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}



