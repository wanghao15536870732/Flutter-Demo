import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../OverAll.dart';
import '../overall_home_widget.dart';
import 'dashed_line_widget.dart';
import 'news.dart';

class NewsHomePage extends StatefulWidget{
  final String title;

  const NewsHomePage({Key key, this.title}) : super(key: key);

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>{

  List<News> newsList = [];
  OverAll overAll;

  @override
  void initState() {
    super.initState();
//    requestPermission();
    requestNews();
  }

//  Future requestPermission() async{
//    Map<PermissionGroup, PermissionStatus> permissions = await
//      PermissionHandler().requestPermissions([PermissionGroup.location,PermissionGroup.storage]);
//    for(var i = 0;i < permissions.length;i ++){
//
//    }
//  }

  Future requestNews() async {
    final newsResponse = await http.get(
        "https://lab.isaaclin.cn/nCoV/api/news");
    final overallResponse = await http.get(
        "https://lab.isaaclin.cn/nCoV/api/overall");
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> newsData = json.decode(utf8decoder.convert(newsResponse.bodyBytes));
    List<News> newsList = NewsList.fromJson(newsData['results']).newsList;
    
    Map<String,dynamic> overallData = json.decode(utf8decoder.convert(overallResponse.bodyBytes));
    OverAll overAll = OverAll.fromJson(overallData['results'][0]);
    setState(() {
      this.newsList = newsList;
      this.overAll = overAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:newsList.length > 0 ? _grayCenter(context) : new Center(child:CupertinoActivityIndicator()),
    );
  }

  //灰色部分
  Widget _grayCenter(BuildContext context){

    List<Widget> widgets = [];
    widgets.add(OverAllHomeWidget(this.overAll));
    for(int index = 0;index < newsList.length;index ++){
      News news = newsList[index];
      Widget widget = index == 0
          ? _getRow(news.title,news.pubDate,news.summary,news.infoSource,true)
          : _getRow(news.title,news.pubDate,news.summary,news.infoSource,false);
      widgets.add(widget);
    }
    print(widgets);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.only(left: 0,right: 15,top: 15,bottom: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children:widgets,
        ),
      )
    );
  }

  String getTimeStr(int pubDate){
    DateTime nowTimeStr = DateTime.now();
    DateTime pubTimeStr = DateTime.fromMillisecondsSinceEpoch(pubDate);
    List<String> timeList = nowTimeStr.difference(pubTimeStr).toString().split(":");
    return timeList[0] == "0" ? timeList[1] + "分钟前" : timeList[0] + "小时" + timeList[1] + "分钟前";
  }

  Widget _getRow(String title,int pubDate,String followupListItem,String infoSource,bool topNews){

    //带底色最新图标
    Widget textWidget(var text) {
      return Container(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.white
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.red[600],
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        padding: EdgeInsets.fromLTRB(2 , 0 , 2 , 0),
        margin: EdgeInsets.only(right: 4.0)
      );
    }

    //跟进记录
    Widget contentWidget = Card(
      elevation: 1.0,//阴影
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  topNews ? textWidget("最新") : Container(),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                ],
              )
            ),
            Container(
              child: Text(
                followupListItem??"--",
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey
                ),
                softWrap: true,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                "信息来源：" + infoSource,
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey
                ),
                softWrap: true,
              ),
            )
          ],
        )
      )
    );

    Widget timeRow = Row(
      children: <Widget>[
        Text(
            getTimeStr(pubDate),
            style: TextStyle(
              fontSize: 13.0,
            )
        )
      ],
    );

    double topSpace = 0;
    topSpace = 3;
    Widget pointWidget = ClipOval(
      child: Container(
        width: 7,
        height: 7,
        color: Colors.blue,
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //灰色右
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: topSpace == 0 ? 4 : 0,
                    ),
                    timeRow,
                    SizedBox(
                      height: 12.0,
                    ),
                    contentWidget,
                    SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                width: 37,
                bottom: 0,
                top: topSpace,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      pointWidget,
                      Expanded(
                        child: Container(
                          width: 27,
                          child: MySeparatorVertical(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}