import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amap_location_plugin/amap_location_plugin.dart';
import 'package:flutter_demo/FlutterLocation/LocationData.dart';

class LocationPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title:Text( 'Flutter Test'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
      body: new Location(),
    );
  }
}

class Location extends StatefulWidget{
  @override
  createState() => new LocationState();
}

class LocationState extends State<Location>{

  Offset _offset = Offset.zero; // changed
  AmapLocation _amapLocation = AmapLocation();
  String cityName;
  LocationData location = LocationData.empty();

  LocationState(){
    _amapLocation.startLocation;
    _getLocation();
  }

  void _getLocation() async {
    String location = await _fetchJson();
    LocationData locationDate = await _fetchLocation();
    setState(() {
      this.cityName = location;
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

  Widget buildBody(){
    if(cityName == null) {
      return new Center(
        child: new Text(
          "Hello World",
          style: new TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      );
    }else{
      return new Center(
        child: new Text(
          cityName,
          style: new TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(0.01 * _offset.dy)
      ..rotateY(-0.01 * _offset.dx),
      alignment: FractionalOffset.center,
      child: GestureDetector(
        // new
        onPanUpdate: (details) =>
            setState(() => _offset += details.delta), //与屏幕接触并移动的指针再次移动
        onDoubleTap: () => setState(() => _offset = Offset.zero),
        child: buildBody(),
      )
    );
  }
}
