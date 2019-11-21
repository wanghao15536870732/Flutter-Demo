
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/DouBanListView.dart';
import 'package:flutter_demo/FlutterDouBanMovie/HotListView.dart';

class MovieHome extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MovieHome> with SingleTickerProviderStateMixin{

  TabController _tabController;
  final _tabs = <String>["正在热映","豆瓣Top250"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController( vsync: this,initialIndex: 0,length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context,innerScrolled) => <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  pinned: true,
                  title: Text("豆瓣电影"),
                  expandedHeight: 230.0,
                  flexibleSpace: FlexibleSpaceBar(background: Image.asset('images/backgroud.jpg',fit: BoxFit.cover,),),
                  bottom: TabBar(controller: _tabController,tabs:<Widget>[Tab(text: _tabs[0]),Tab(text: _tabs[1])]),
                  forceElevated: innerScrolled,
                ),
              )
            ],
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                HotMovieList(),
                DouBanListView(),
              ],
            ),
          )
      )
    );
  }
}