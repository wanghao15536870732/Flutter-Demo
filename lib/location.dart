import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amap_location_plugin/amap_location_plugin.dart';

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

  AmapLocation _amapLocation = AmapLocation();
  Future<String> cityName;

  LocationState(){
    _amapLocation.startLocation;
    cityName = _amapLocation.getLocation;
    print(_amapLocation.getLocation);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        cityName.toString() == null ? "Hello World" : cityName.toString(),
        style: new TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
