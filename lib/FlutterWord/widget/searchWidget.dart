
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lake/FlutterWeather/data/CityData.dart';
import 'package:flutter_lake/FlutterWeather/widget/WeatherWidget.dart';
import 'package:http/http.dart' as http;

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  CityList cityList = CityList.empty();

  void getCitys(String str) async{
    CityList citylist = await _fetchCitys(str);
    setState(() {
      cityList = citylist;
    });
  }

  Future<CityList> _fetchCitys(String str) async{
    final response = await http.get('https://search.heweather.net/find?parameters&location=' +
        str +
        '&key=551f547c64b24816acfed8471215cd0e'
    );
    if(response.statusCode == 200){
      return CityList.frommap(json.decode(response.body));
    }else{
      return CityList.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: const Alignment(0.0,-1.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0),
//              color: Colors.red,
              child: TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Please enter your city'),
                onChanged: (str) {
                  getCitys(str);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: ListView.builder(
              itemCount: cityList.citys.length,
              itemBuilder: (context, index) => EntryItem(cityList.citys[index],cityList.citynames[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class EntryItem extends StatelessWidget {

  final dynamic place;
  final dynamic name;

  const EntryItem(this.place,this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: ((){
        Navigator.push( //相当于Android里面得Intent
          context,
          MaterialPageRoute(builder: (context) => WeatherWidget(name)),
        );
      }),
      child: ListTile(
        title: Text(place.toString()),
      ),
    );
  }
}