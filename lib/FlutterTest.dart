
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_lake/FlutterPicker/PicPage.dart';
import 'package:flutter_lake/FlutterWeather/weather.dart';
import 'package:flutter_lake/FlutterWord/word.dart';

class FlutterTest extends StatefulWidget {
  @override
  _FlutterTestState createState() => _FlutterTestState();
}

class _FlutterTestState extends State<FlutterTest> {

  int curIndex = 0;

  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('pic looker'),
      ),
        body: new Scaffold(
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.photo),title: new Text('图片')
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.change_history),title: new Text('null')
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.change_history),title: new Text('null')
            ),
          ],currentIndex: curIndex,onTap:bottomNavigationBarSelect),
          body: new PageView.builder(
              itemBuilder: (BuildContext context,int index){
                switch(index){
                  case 0:
                    return new PicPage();
                  case 1:
                    return new PicPage();
                  case 2:
                    return new PicPage();
                  case 3:
                    return new PicPage();
                }
              },
            itemCount: 3,
            onPageChanged: onPageChanged,
            controller: pageController,
          ),
        )
    );
  }

  void onPageChanged(int index) {
    curIndex = index;
    setState(() {});
  }

  void bottomNavigationBarSelect(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
