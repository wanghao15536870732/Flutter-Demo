
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FlutterTest extends StatefulWidget {
  @override
  _FlutterTestState createState() => _FlutterTestState();
}

class _FlutterTestState extends State<FlutterTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Test'),
      ),
      body: new Center(
        child: new Text('Hello World'),
      ),
    );
  }
}
