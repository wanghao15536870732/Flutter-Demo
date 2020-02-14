import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/news/api.dart';
import 'package:flutter_app/news/source_webview.dart';
import 'package:flutter_app/overall/over_all.dart';
import 'package:flutter_app/overall/overall_home_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dashed_line_widget.dart';
import 'package:flutter_app/news/news.dart';

class NewsHomePage extends StatefulWidget{

  List<News> newsList;
  OverAll overAll;

  NewsHomePage({Key key, this.newsList, this.overAll}) : super(key: key);

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>{

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return this.widget.newsList.length > 0
        ? _grayCenter(context)
        : new Center(child:CupertinoActivityIndicator());
  }

  //灰色部分
  Widget _grayCenter(BuildContext context){
    //查看更多
    Widget moreNewsWidget = Container(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "查看更多",
            style: TextStyle(fontSize: 15.0,color: Colors.blue),
          ),
          Icon(Icons.arrow_right,color: Colors.blue,size: 24.0,),
        ],
      ),
    );

    List<Widget> newsWidgets = [];
    for(int index = 0;index < this.widget.newsList.length;index ++){
      News news = this.widget.newsList[index];
      Widget widget = index == 0
          ? _getRow(news,true)
          : _getRow(news,false);
      newsWidgets.add(widget);
    }
    newsWidgets.add(moreNewsWidget);

    //新闻列表
    Widget newsWidget = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.only(left: 0,right: 15,top: 15,bottom: 10),
      child: Column(
        children:newsWidgets,
      ),
    );

    //下拉刷新
    void _onRefresh() async{
      OverAll overAll = await API.requestOverall();
      List<News> newsList = await API.requestNews(true);
      setState(() {
        this.widget.overAll = overAll;
        this.widget.newsList = newsList;
      });
      _refreshController.refreshCompleted();
    }

    return SmartRefresher(
        enablePullUp: false,
        enablePullDown: true,
        header: ClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body;
            if(mode==LoadStatus.idle){
              body = Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body = CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              OverAllHomeWidget(this.widget.overAll),
              Container(height: 15.0,color: Colors.grey[200]),
              titleWidget("实时播报"),
              newsWidget,
            ],
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

  Widget _getRow(News news,bool topNews){
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
                  Expanded(
                    child: Text(
                      news.title,
                      style: TextStyle(fontSize: 16.0, color: Colors.black,),
                      softWrap: true,
                    ),
                  )
                ],
              )
            ),
            Container(
              child: Text(
                news.summary??"--",
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
                "信息来源：" + news.infoSource,
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
            getTimeStr(news.pubDate),
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
        Expanded(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: Container(
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          WebViewPage(title: news.title,url:news.sourceUrl)));
                },
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