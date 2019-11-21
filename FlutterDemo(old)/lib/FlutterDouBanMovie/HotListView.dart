import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/DouBanListView.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'package:http/http.dart' as http;

class HotMovieList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HotState();
  }
}

class HotState extends State<HotMovieList>{
  var entries = [];
  var itemHeight = 150.0;
  final Set<dynamic> _saved = new Set();
  var details;
  String ratingValue ;

  requestMovieTop() async {
    final response = await http.get(
        "http://api.douban.com/v2/movie/nowplaying?apikey=0df993c66c0c636e29ecbb5344252a4a");
    Map<String,dynamic> data = json.decode(response.body);
    setState(() {
      entries = data['entries'];
    });
  }

  @override
  void initState() {
    super.initState();
    requestMovieTop();
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      body: new Container(
        margin: EdgeInsets.only(top: 105.0),
        child: getListViewContainer(),
      ),
    );
  }

  getListViewContainer() {
    if (entries.length == 0) {
      //loading
      return new Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return ListView.builder(
      //item 的数量
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            //Flutter 手势处理
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberWidget(index + 1),  //NO.1 图标
                  getItemContainerView(entries[index]),
                  //下面的灰色分割线
                  Container(
                    height: 10,
                    color: Color.fromARGB(255, 234, 233, 234),
                  )
                ],
              ),
            ),
            onTap: () {

            }
          );
        });
  }

  //肖申克的救赎(1993) View
  getTitleView(subject) {
    var title = subject['title'];
    var year = subject['pubdate'];
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
                textScaleFactor:  7.5 / title.length > 1.0 ? 1.0 : 7.5 / title.length,  //放大倍数
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Text('上映时间：$year',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))
        ],
      )
    );
  }

  getItemContainerView(var subject) {
    bool alreadySaved = _saved.contains(subject);
    var imgUrl = subject['images']['medium'];
    var title = subject['title'];
    var year = subject['pubdate'];
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

    var start = subject['rating'];
    return Container(
      height: itemHeight,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          getTitleView(subject),
          start == "" ? new Row(
            mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
              Text("暂无评分",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.grey),)
          ],) :RatingBar(double.parse(start),18.0,Colors.grey),
        ],
      ),
    );
  }

  //NO.1 图标
  numberWidget(var no) {
    return Container(
      child: Text(
        'No.$no',
        style: TextStyle(color: Color.fromARGB(255, 133, 66, 0)),
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 201, 129),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.only(left: 12, top: 10),
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