
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lake/FlutterWeather/data/CityData.dart';
import 'package:flutter_lake/FlutterWeather/widget/CityWidget.dart';
import 'package:flutter_lake/FlutterWeather/widget/WeatherWidget.dart';
import 'package:flutter_lake/FlutterWord/widget/searchWidget.dart';

void main(){
  setCustomErrorPage();
  runApp(Weather());
}

void setCustomErrorPage(){
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails){
    print(flutterErrorDetails.toString());
    return Center(
      child: Text("Flutter 走神了"),
    );
  };
}

class Weather extends StatelessWidget{

  final _saved = new Set<String>();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void _pushCity(){
      Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (context){
                final tiles = _saved.map(
                        (cityName){
                      return new ListTile(
                        title: new Text(
                          cityName,
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    }
                );

                final divided = ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList();

                Widget _buildSave() {
                  return ListView(
                    children: divided,
                  );
                }

                return new Scaffold(
                  appBar: new AppBar(
                    title: new Text('你关注的城市'),
                  ),
                  body: _buildSave(),
                );
              }
          )
      );
    }

    return new MaterialApp(
      title: 'Flutter Weather',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false, //false键盘弹起不重新布局 避免挤压布局
        appBar: new AppBar(
          title: new Text('Select City'),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed:(){
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => new SearchWidget())
                  );}
                ),
            new IconButton(
              icon: new Icon(Icons.location_city),
              onPressed: _pushCity
            )
          ],
        ),
        body: CityWidget(),
      )
    );
  }
}
