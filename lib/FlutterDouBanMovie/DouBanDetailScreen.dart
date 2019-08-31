import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/actor_detail/actor_detail_view.dart';
import 'package:flutter_demo/FlutterDouBanMovie/movie/movie_detail_view.dart';
import 'package:flutter_demo/FlutterDouBanMovie/movie/movie_summery_view.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'package:http/http.dart' as http;

class DouBanDetailScreen extends StatefulWidget {
  var subject;
  DouBanDetailScreen({Key key, @required this.subject}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DouBanDetailState(subject);
  }
}

class DouBanDetailState extends State<DouBanDetailScreen>{

  var title;
  var subject;
  var summary; //电影简介
  bool isSummaryUnfold = false;

  DouBanDetailState(var subject){
    this.subject = subject;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestMovieDetail();
  }



  requestMovieDetail() async {
    var movieId = subject['id'];
    var title = subject['title'];
    print(movieId);
    final response = await http.get(
        "https://api.douban.com/v2/movie/subject/" + movieId +
            "?apikey=0df993c66c0c636e29ecbb5344252a4a");
    Map<String,dynamic> data = json.decode(response.body);
    setState(() {
      this.summary = data['summary'];
      this.title = title;
    });
  }

  movieCard(var subject) {
    var imgUrl = subject['images']['medium'];
    var title = subject['title'];
    return new Hero(
      tag: title,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 8.0,
            child: Container(
                child: Image.network(imgUrl),
                margin: EdgeInsets.all(10.0)
            ),
          ),
        ],
      ),
    );
  }

  Widget director(var img,var name,var id) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
          child: new Hero(
              tag: id,
              child: GestureDetector(
                onTap: (){
                  //Toast.toast(context, id);
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context) => ActorDetailView(id: id)),
                  );
                },
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(img),
                ),
              ),
          ),
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
        ),
        Container(
          child: new Text(
              name,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          padding: EdgeInsets.only(
            top: 10,
          ),
        )
      ],
    );
  }

  Widget directorsCard(var subject){
    var imageUrls = subject['directors'];
    List<Widget> directors = new List();
    for(int i = 0;i < imageUrls.length;i ++){
      var name = imageUrls[i]['name'];
      var name_en = imageUrls[i]['name_en'];
      var name_l = name_en + '\n' + name;
      var img = imageUrls[i]['avatars']['small'];
      var id = imageUrls[i]['id'];
      directors.add(director(img,name_l,id));
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        directors[0],
      ],
    );
  }

  Widget castsCard(var subject){
    var casts = subject['casts'];
    List<Widget> castsList = new List();
    for(int i = 0;i < casts.length;i ++){
      var name = casts[i]['name'];
      var img = casts[i]['avatars']['small'];
      var id  = casts[i]['id'];
      castsList.add(director(img, name,id));
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        castsList[0],
        castsList[1],
        castsList[2],
      ],
    );
  }

  Widget titleWidget(var no) {
    return Container(
      child: Text(
        no,
        style: TextStyle(color: Colors.blueGrey),
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 201, 129),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.only(left: 8.0, top: 10,bottom: 8.0),
    );
  }

  //展开 / 收起
  changeSummeryMaxLines(){
    setState(() {
      isSummaryUnfold = ! isSummaryUnfold;
    });
  }

  getItemContainerView(var subject) {
    return Container(
      color: Color.fromARGB(245, 255, 255, 255),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(10),
      child: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 10),
              child: movieCard(subject),
            ),
            MovieDetailView(subject['title'],subject['rating']['average'],subject['year'],subject),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleWidget("简介"),
                MovieSummaryView(summary,isSummaryUnfold,changeSummeryMaxLines),
                titleWidget("导演"),
                directorsCard(subject),
                titleWidget("演职员"),
                castsCard(subject),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('电影详情'),
      ),
      body: getItemContainerView(subject),
    );
  }
}