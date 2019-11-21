import 'dart:convert';
import 'package:demoflutter/FlutterDouBanMovie/DouBanDetailScreen.dart';
import 'package:demoflutter/utils/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DouBanListView.dart';

class HotMovieList extends StatefulWidget{

  var subjectList = [];

  HotMovieList({Key key, @required this.subjectList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HotState(subjectList);
  }
}

class HotState extends State<HotMovieList>{
  var subjects = [];
  var itemHeight = 150.0;
  final Set<dynamic> _saved = new Set();
  var details;
  String ratingValue ;

  HotState(var subjectList){
    this.subjects = subjectList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      body: new Container(
        margin: EdgeInsets.only(top:5.0),
        child: getListViewContainer(),
      ),
    );
  }

  getListViewContainer() {
    if (subjects.length == 0) {
      //loading
      return new Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return ListView.builder(
      //item 的数量
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            //Flutter 手势处理
            child: Container(
              margin: EdgeInsets.only(top:5.0),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getItemContainerView(subjects[index]['subject']),
                  //下面的灰色分割线
                  Container(
                    height: 10,
                    color: Color.fromARGB(255, 234, 233, 234),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DouBanDetailScreen(
                        subject: subjects[index]['subject'],
                      )));
            }
          );
        });
  }

  //肖申克的救赎(1993) View
  getTitleView(subject) {
    var title = subject['title'];
    var year = subject['year'];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.play_circle_outline,
                color: Colors.redAccent,
              ),
              Text(
                title,
                overflow: TextOverflow.fade,  //当自超过屏幕时，渐渐隐去
                textScaleFactor:  8.5 / title.length > 1.0 ? 1.0 : 8.5 / title.length,  //放大倍数
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      )
    );
  }

  getItemContainerView(var subject) {
    bool alreadySaved = _saved.contains(subject);
    var imgUrl = subject['images']['small'];
    var title = subject['title'];
    var year = subject['year'];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          new Hero(
            tag: 'tag$title$year',
            child: getImage(imgUrl),
          ),
          Expanded(
            child: getMovieInfoView(subject),
            flex: 1,
          ),
          new Container(
              margin: EdgeInsets.only(left: 1.0,right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      icon:new Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: Colors.orangeAccent,
                      ),
                      onPressed: (){
                        setState(() {
                          if(alreadySaved){
                            _saved.remove(subject);
                            Toast.toast(context, "已取消收藏");
                          }else{
                            _saved.add(subject);
                            Toast.toast(context, "已收藏");
                          }
                        });
                      }
                  ),
                  new Text(
                    "收藏",
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  //圆角图片
  getImage(var imgUrl) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      height: itemHeight,
      width: 100.0,
    );
  }

  getStaring(var stars) {
    return Row(
      children: <Widget>[RatingBar(stars,18.0,Colors.grey), Text('$stars')],
    );
  }

  //电影标题，星标评分，演员简介Container
  getMovieInfoView(var subject) {
    var start = subject['rating']['average'];
    return Container(
      height: itemHeight,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          getTitleView(subject),
          start == "" ? new Row(
            mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
              Text("暂无评分",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.grey),)
          ],) :RatingBar(start,18.0,Colors.grey),
          DescWidget(subject),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  String value() {
    if(ratingValue == null) {
      return '评分：9 分';
    }else {
      return '评分：$ratingValue  分';
    }
  }
}