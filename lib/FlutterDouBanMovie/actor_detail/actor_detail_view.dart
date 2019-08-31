import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/actor_detail/actor_detail_header.dart';
import 'package:flutter_demo/FlutterDouBanMovie/actor_detail/actor_detail_works.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_actor_detail.dart';
import 'package:flutter_demo/FlutterDouBanMovie/movie/movie_summery_view.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class ActorDetailView extends StatefulWidget {
  // 演员 id
  final String id;
  const ActorDetailView({Key key, this.id}) : super(key: key);

  @override
  _ActorDetailViewState createState() => _ActorDetailViewState();
}

class _ActorDetailViewState extends State<ActorDetailView> {

  MovieActorDetail actorDetail;
  bool isSummaryUnfold = false;
  Color pageColor = Colors.white;
  ScrollController scrollController = ScrollController();

  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async{
    final response = await http.get(
        "http://api.douban.com/v2/movie/celebrity/" + this.widget.id +
            "?apikey=0df993c66c0c636e29ecbb5344252a4a");
    Map<String,dynamic> data = json.decode(response.body);
    MovieActorDetail detail = MovieActorDetail.fromJson(data);
    pageColor = Image.network(detail.avatars.small).color;
    setState(() {
      this.pageColor = pageColor;
      this.actorDetail = detail;
    });
//    print(actorDetail != null);
  }

  @override
  Widget build(BuildContext context) {

    if (actorDetail == null) {
      return Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ));
    }
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Container(
            color: pageColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0.0),
                    children: <Widget>[
                      ActorDetailHeader(actorDetail,pageColor),
                      Container(
                        margin: EdgeInsets.only(top: 10.0,left: 10.0),
                        child: Text(
                          "简介",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MovieSummaryView(actorDetail.summary,isSummaryUnfold,changeSummaryMaxLines),
                      ActorDetailWorks(actorDetail.works),
                    ],
                  ),
                )
              ],
            ),
          ),
          new Stack(
            children: <Widget>[
              Container(
                width: 44,
                height: MediaQueryData.fromWindow(ui.window).padding.top + kToolbarHeight,
                padding: EdgeInsets.fromLTRB(5,MediaQueryData.fromWindow(ui.window).padding.top, 0, 0),
                child: GestureDetector(onTap:(){ Navigator.pop(context);},child:Icon( Icons.arrow_back,color: Colors.white,)),
              )
            ],
          )
        ],
      ),
    );
  }

}