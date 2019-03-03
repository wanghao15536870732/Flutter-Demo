import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PicListWidget();
  }
}

class PicListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PicListWidgetState();
  }
}

class PicListWidgetState extends State<PicListWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text('Hello World'),
    );
  }

}
