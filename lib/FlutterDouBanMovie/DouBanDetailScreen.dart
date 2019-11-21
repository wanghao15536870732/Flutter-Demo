import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DouBanListView.dart';
import 'actor_detail/actor_detail_photo.dart';
import 'actor_detail/actor_detail_view.dart';
import 'model/MovieTrailer.dart';
import 'model/movie_comment_item.dart';
import 'model/movie_photo.dart';
import 'movie/movie_detail_view.dart';
import 'movie/movie_summery_view.dart';
import 'movie/movie_webview.dart';

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
  var comments = [];
  List<Widget> children = [];
  List<MovieCommentItem> items = [];
  List<MoviePhoto> images = []; //剧照
  String videoUrl; //视频播放链接
  List<MovieTrailer> trailers = [];
  List<MovieTrailer> bloopers = [];

  DouBanDetailState(var subject){
    this.subject = subject;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestMovieDetail();
    requestMoviePhoto();
  }

  requestMovieDetail() async {
    var movieId = subject['id'];
    var title = subject['title'];
    print(movieId);
    final response = await http.get(
        "https://api.douban.com/v2/movie/subject/" + movieId +
            "?apikey=0df993c66c0c636e29ecbb5344252a4a");
    Map<String,dynamic> data = json.decode(response.body);
    String videoUrl = data['alt'];
    print(videoUrl);
    List<MovieCommentItem> items = await _fetchCommentItem(data);
    List<MovieTrailer> trailers = MovieTrailerList.fromJson(data['trailers']).trailers;
    List<MovieTrailer> bloopers = MovieTrailerList.fromJson(data['bloopers']).trailers;
    setState(() {
      this.summary = data['summary'];
      this.title = title;
      this.items = items;
      this.videoUrl = videoUrl;
      this.trailers = trailers;
      this.bloopers = bloopers;
    });
  }

  requestMoviePhoto() async{
    var movieId = subject['id'];
    final response = await http.get(
        "https://api.douban.com/v2/movie/subject/" + movieId +
            "/photos?apikey=0df993c66c0c636e29ecbb5344252a4a");
    Map<String,dynamic> data = json.decode(response.body);
    var photos = data['photos'];
    List<MoviePhoto> images = [];
    for(var i = 0;i < photos.length;i ++){
      images.add(MoviePhoto.fromJson(photos[i]));
    }
    setState(() {
      this.images = images;
    });
  }

  Future _fetchCommentItem(Map data) async{
    var comments = data['popular_comments'];
    print(comments.length);
    List<MovieCommentItem> items = [];
    for(var i = 0;i < comments.length;i ++){
      items.add(MovieCommentItem.fromJson(comments[i]));
    }
    return items;
  }

  Widget commentList(){
    for (var i = 0; i < items.length; i ++) {
      children.add(commentItem(items[i], i));
    }
    return new Container(
      color: Colors.black45,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "短评",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          SizedBox.fromSize(
              size: Size.fromHeight(400.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: children,
            )
          )
        ],
      ),
    );
  }

  Widget commentItem(MovieCommentItem item,int index){
    return Container(
      margin: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                margin: EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(item.avatar),
                  radius: 50.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5.0,left: 5.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new RatingBar(item.movieRate.max * 2,12.0,Colors.white),
                        new Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            item.created_at,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Container(
            width: 370.0,
            child: Text(
              item.content,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                child: Icon(
                  Icons.thumb_up,
                  size: 12.0,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                child: new Text(
                  numberToK(item.useful_count),
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String numberToK(int number){
    double num;
    if(number >= 1000){
      num = number / 1000;
      return num.toStringAsFixed(1) + 'K';
    }
    return number.toString();
  }

  movieCard(var subject) {
    var imgUrl = subject['images']['medium'];
    var title = subject['title'];
    var year = subject['year'];
    return Stack(
      children: <Widget>[
        new Hero(
          tag: 'tag$title$year',
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
        ),
        Container(
          width: 380.0,
          height: 410.0,
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: GestureDetector(
                onTap: (){
                  print(videoUrl);
                  videoUrl != null ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MovieWebViewPage(title: subject['title'],movieUrl: this.videoUrl,))): print("videoUrl is null");
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
      ],
    );
  }

  Widget director(var img,var name,var id) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5.0,right: 5.0,top: 5.0,bottom: 5.0),
          child: new Hero(
              tag: id,
              child: GestureDetector(
                onTap: (){
                  //Toast.toast(context, id);
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context) => ActorDetailView(id: id)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
                  height: 120.0,
                  width: 70.0,
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
            top: 5.0,
            bottom: 10.0
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
      children: castsList
    );
  }

  Widget titleWidget(var no) {
//    return Container(
//      child: Text(
//        no,
//        style: TextStyle(color: Colors.blueGrey),
//      ),
//      decoration: BoxDecoration(
//          color: Color.fromARGB(255, 255, 201, 129),
//          borderRadius: BorderRadius.all(Radius.circular(5.0))),
//      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
//      margin: EdgeInsets.only(left: 8.0, top: 10,bottom: 8.0),
//    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        no,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
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
                subject['casts'].length != 0 ? titleWidget("演职员") : new Container(),
                castsCard(subject),
                ActorDetailPhoto(actorId: subject['id'],photos: images,title: "剧照",horizontal: 10.0,trailers: this.trailers,bloopers: this.bloopers,),
                items.length > 0 ? commentList() : Center(child: CupertinoActivityIndicator(),),
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