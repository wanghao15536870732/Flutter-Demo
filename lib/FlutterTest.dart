
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lake/FlutterPicker/PicPage.dart';
import 'package:audioplayer/audioplayer.dart';

typedef void OnError(Exception exception);

const kUrl = "http://www.rxlabz.com/labz/audio2.mp3";
const kUrl2 = "http://www.rxlabz.com/labz/audio.mp3";

enum PlayerState{stoped,playing,paused}

class FlutterTest extends StatefulWidget {
  @override
  _FlutterTestState createState() => _FlutterTestState();
}

class _FlutterTestState extends State<FlutterTest> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('pic looker'),
      ),
        body: new PicPage()
    );
  }

}
