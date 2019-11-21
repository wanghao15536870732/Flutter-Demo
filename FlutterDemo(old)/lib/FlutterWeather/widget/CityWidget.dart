
import 'dart:convert';
import 'package:amap_location_plugin/amap_location_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/LocationData.dart';
import 'package:flutter_demo/FlutterWeather/data/CityData.dart';
import 'package:flutter_demo/FlutterWeather/widget/WeatherWidget.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'package:http/http.dart' as http;

class CityWidget extends StatefulWidget{

  static final citysaved = new Set<CityData>();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CityState();
  }
}

class CityState extends State<CityWidget>{

  AmapLocation _amapLocation = AmapLocation();
  LocationData location = LocationData.empty();

  Set _saved = new Set<CityData>();
  //列表显示
  List<CityData> cityList = new List<CityData>();


  CityState(){
    _amapLocation.startLocation;
    _getCityList(); //获取城市列表
    _getLocation();
  }

  void _makeToast(String msg) async{
    await Toast.toast(context, msg);
  }

  void _getLocation() async {
    LocationData locationDate = await _fetchLocation();
    setState(() {
      this.location = locationDate;
    });
  }

  Future<LocationData> _fetchLocation() async {
    final response = await _fetchJson();
    if(response != null){
      return LocationData.fromJson(json.decode(response));
    }else{
      return LocationData.empty();
    }
  }

  Future<String> _fetchJson() async {
    String location = await _amapLocation.getLocation;
    return location;
  }



  void _getCityList() async{  //async关键字声明该函数内部有代码需要延迟执行
    List<CityData> citys = await _fetchCityList();  //await关键字声明运算为延迟执行，然后return运算结果
    setState(() {
      cityList = citys;
    });
  }

  /*
  Future就是event，很多Flutter内置的组件比如Http（http请求控件）的get函数、
  RefreshIndicator（下拉手势刷新控件）的onRefresh函数都是event。
  每一个被await标记的句柄也是一个event，每创建一个Future就会把这个Future扔进event queue中排队等候安检
  * */

  Future<List<CityData>> _fetchCityList() async{  //有await标记的运算，其结果值都是一个Future对象，
    final response = await http.get('https://search.heweather.net/top?group=cn&number=50&key=551f547c64b24816acfed8471215cd0e');
    List<CityData> cityList = new List<CityData>();
    cityList.add(new CityData('使用GPS定位'));
    if(response.statusCode == 200){
      //解析数据
      Map<String,dynamic> result = json.decode(response.body);
      for(dynamic data in result['HeWeather6'][0]['basic']) {
        CityData cityData = CityData(data['location']);
        cityList.add(cityData);
      }
      return cityList;
    }else{
      return cityList;
    }
  }


  Widget _buildRow(CityData citydata,int index){
    final alreadySaved = _saved.contains(citydata);
    if(index == 0){
      return new ListTile(
        title: GestureDetector(
          child: Text(cityList[index].cityName),
          onTap: (){  //List的Item
            //_getLocation();
            location == null
                ? _makeToast("请开启位置权限,并重新打开该应用")
                : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WeatherWidget(location.city.split("市")[0])
              ),
            );
            print(location.city.split("市")[0]);
          },
        ),
        trailing: new Icon(
          Icons.location_on,
        ),
        onTap: (){
          //定位转到
        },
      );
    } else{
      return new ListTile(
        title: GestureDetector(
          child: Text(cityList[index].cityName),
          onTap: (){  //List的Item
            Navigator.push( //相当于Android里面得Intent
              context,
              MaterialPageRoute(builder: (context) => WeatherWidget(cityList[index].cityName)),
            );
          },
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: (){
          setState(() {  //当图标被点击时，函数调用setState()会为State对象触发build()方法，从而导致对UI的更新
            if(alreadySaved){  //如果单词条目已经添加到收藏夹中
              _saved.remove(citydata);  //再次点击它将其从收藏夹中删除
            }else{
              _saved.add(citydata);
            }
          });
        },
      );
    }
  }

  Set returnSave(){
    return this._saved;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cityList.length,
      itemBuilder: (context,index){
        return _buildRow(cityList[index], index);
      },
    );
  }
}
