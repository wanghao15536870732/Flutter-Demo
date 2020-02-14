import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/news/api.dart';
import 'package:flutter_app/news/news.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RumorHomePage extends StatefulWidget {
  List<Rumor> rumorList;

  RumorHomePage({Key key, this.rumorList}) : super(key: key);

  @override
  _RumorHomePageState createState() => _RumorHomePageState();
}

class _RumorHomePageState extends State<RumorHomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> rumorWidgets = [];

  Widget rumorWidget(BuildContext context){

    List<Rumor> rumors = this.widget.rumorList;
    for(int i = 0;i < rumors.length;i ++){
      rumorWidgets.add(rumorItem(rumors[i]));
    }
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: rumorWidgets,
        ),
      )
    );
  }

  Widget rumorItem(Rumor rumor) {
    return Container(
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 5.0),
        child: Column(
          children: <Widget>[
            LayoutBuilder(builder:(context, constraints){
              return Container(
                width: constraints.constrainWidth(),
                  color: Colors.blueAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text("谣言", 
                            style: TextStyle(fontSize: 28.0, color: Colors.white,
                                fontFamily: 'MaShanZheng')),
                      ),
                      Container(
                        color: Colors.blue,
                        margin: EdgeInsets.all(5.0),
                        child: Text(rumor.title,
                          style: TextStyle(fontSize: 20.0, color: Colors.white,fontWeight: FontWeight.w500), softWrap: true),
                      ),
                    ],
                  )
              );
            }),
            Container(
              margin: EdgeInsets.all(5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                rumor.mainSummary ?? "--",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Text(
                rumor.body,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  //下拉刷新
  void _onRefresh() async {
    this.widget.rumorList = await API.requestRumors(true);
    _refreshController.refreshCompleted();
  }

  //滑到底部刷新
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (mounted)
      setState(() {

    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: false,
      enablePullDown: true,
      header: ClassicHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: rumorWidget(context),
    );
  }
}
