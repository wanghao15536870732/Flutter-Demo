import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/DouBanDetailScreen.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'package:http/http.dart' as http;

class DouBanListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DouBanState();
  }
}

class DouBanState extends State<DouBanListView> with AutomaticKeepAliveClientMixin{
  var subjects = [];
  var itemHeight = 150.0;
  final Set<dynamic> _saved = new Set();
  var details;

  requestMovieTop() async {
    final response = await http.get(
        "http://api.douban.com/v2/movie/top250?apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=150");
    Map<String,dynamic> data = json.decode(response.body);
    setState(() {
      subjects = data['subjects'];
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
      appBar: new AppBar(
        title: new Text("豆瓣电影Top250"),
      ),
      body: new Container(
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
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberWidget(index + 1),  //NO.1 图标
                  getItemContainerView(subjects[index]),
                  //下面的灰色分割线
                  Container(
                    height: 10,
                    color: Color.fromARGB(255, 234, 233, 234),
                  )
                ],
              ),
            ),
            onTap: () {
              //监听点击事件
              print("click item index=$index");
              //跳转到详情页面
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DouBanDetailScreen(
                        subject: subjects[index],
                      )));
            },
          );
        });
  }

  //肖申克的救赎(1993) View
  getTitleView(subject) {
    var title = subject['title'];
    var year = subject['year'];
    return Container(
      child: Row(
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
          Text('($year)',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))
        ],
      ),
    );
  }

  getItemContainerView(var subject) {
    bool alreadySaved = _saved.contains(subject);
    var imgUrl = subject['images']['medium'];
    var title = subject['title'];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          new Hero(
              tag: title,
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
      children: <Widget>[RatingBar(stars,18.0), Text('$stars')],
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
          RatingBar(start,18.0),
          DescWidget(subject)
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
}

//类别、演员介绍
class DescWidget extends StatelessWidget {
  var subject;

  DescWidget(this.subject);

  @override
  Widget build(BuildContext context) {
    var casts = subject['casts'];
    var sb = StringBuffer();
    var genres = subject['genres'];
    var directors = subject['directors'];
    var durations = subject['durations'];
    for (var i = 0; i < genres.length; i++) {
      sb.write('${genres[i]}  ');
    }
    sb.write("/ ");
    sb.write('片长：' + durations[0]);
    sb.write("/ ");
    List<String> directorsList = List.generate(
        directors.length, (int index) => directors[index]['name'].toString());
    for (var i = 0; i < directorsList.length; i++) {
      sb.write('${directorsList[i]} ');
    }
    sb.write("/ ");
    List<String> genresList = List.generate(
        casts.length, (int index) => casts[index]['name'].toString());
    for (var i = 0; i < genresList.length; i++) {
      sb.write('${genresList[i]} ');
    }
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sb.toString(),
        softWrap: true,
        textDirection: TextDirection.ltr,
        maxLines: 4,
        style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 118, 117, 118)),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  double stars;
  double size;
  RatingBar(this.stars,this.size);

  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    //实心星星
    var startNumber = stars ~/ 2;
    //半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: size,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: size,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: size,
      ));
    }
    startList.add(Text(
      '$stars',
      style: TextStyle(
        color: Colors.grey,
        fontSize: size,
      ),
    ));
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 5),
      child: Row(
        children: startList,
      ),
    );
  }
}