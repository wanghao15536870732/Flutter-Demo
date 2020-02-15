import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/news/api.dart';
import 'package:flutter_app/news/source_webview.dart';
import 'package:flutter_app/overall/over_all.dart';
import 'package:flutter_app/overall/overall_home_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dashed_line_widget.dart';
import 'package:flutter_app/news/news.dart';

class NewsHomePage extends StatefulWidget {
  List<News> newsList;
  OverAll overAll;
  List<Recommend> recommendList;
  List<Wiki> wikiList;

  NewsHomePage({Key key, this.newsList, this.overAll, this.recommendList,this.wikiList})
      : super(key: key);

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return this.widget.newsList.length > 0
        ? _grayCenter(context)
        : new Center(child: CupertinoActivityIndicator());
  }

  //灰色部分
  Widget _grayCenter(BuildContext context) {
    //查看更多
    Widget moreNewsWidget = Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "查看更多",
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          ),
          Icon(
            Icons.arrow_right,
            color: Colors.blue,
            size: 24.0,
          ),
        ],
      ),
    );

    List<Widget> newsWidgets = [];
    for (int index = 0; index < this.widget.newsList.length; index++) {
      News news = this.widget.newsList[index];
      Widget widget = index == 0
          ? _getRow(news, true, context)
          : _getRow(news, false, context);
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
      padding: EdgeInsets.only(left: 0, right: 15, top: 15, bottom: 10),
      child: Column(
        children: newsWidgets,
      ),
    );

    String _getTitle(int contentType){
      switch(contentType){
        case 1:
          return "我要出行";
          break;
        case 2:
          return "家有小孩";
          break;
        case 3:
          return "给医务者";
          break;
        case 4:
          return "我宅在家";
          break;
        case 6:
          return "家有孕妇";
          break;
        default:
          return "无";
          break;
      }
    }

    Color getColor(int contentType){
      switch(contentType){
        case 3:
          return Colors.green;
          break;
        case 2:case 6:
          return Colors.pink[300];
          break;
        default:
          return Colors.blue[700];
          break;
      }
    }

    Widget _buildRecommend(List<Recommend> recommendList) {
      return Container(color: Colors.grey[300],
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: recommendList.asMap().map((i, v) => MapEntry(i,
              Container(color: Colors.white, margin: EdgeInsets.only(bottom: 1.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(width: 220.0, child: Text(
                              recommendList[i].title,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                            ),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Text(_getTitle(recommendList[i].contentType),
                                      style: TextStyle(fontSize: 13.0, color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: getColor(recommendList[i].contentType),
                                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                                    padding:
                                    EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    margin: EdgeInsets.only(right: 5.0,top: 5.0)
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    DateTime.fromMillisecondsSinceEpoch(recommendList[i].modifyTime)
                                        .toString().substring(0, 10),
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          width: 120.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: recommendList[i].imgUrl,
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                  title: recommendList[i].title, url: recommendList[i].linkUrl)));
                    },
                  )
              )
          )).values.toList()
        )
      );
    }

    Widget _buildWiki(List<Wiki> wikiList){
      return Container(
        color: Colors.grey[200],
        margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
        child: Column(
          children: wikiList.asMap().map((i, v) => MapEntry(i,
            Card(elevation: 1.0,child: Container(
              child: wikiList[i].imgUrl == ""
                  ? Container(margin: EdgeInsets.only(top: 15.0,right: 10.0,left: 10.0,bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(wikiList[i].title,style: TextStyle(fontSize: 16.0,color: Colors.black)),
                      Text(wikiList[i].description,style: TextStyle(fontSize: 14.0,color: Colors.grey[600]),
                          softWrap: true),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text("查看详情", style: TextStyle(fontSize: 14.0,color: Colors.blue[600])),
                      )
                    ],
                  ),
              ) : Container(
                margin: EdgeInsets.only(top: 15.0,right: 10.0,left: 10.0,bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 110.0,
                      height: 100.0,
                      margin: EdgeInsets.all(10.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: wikiList[i].imgUrl,
                        placeholder: (context, url) => CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    Container(
                      width: 230.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(wikiList[i].title,style: TextStyle(fontSize: 16.0,color: Colors.black)),
                          Text(wikiList[i].description,style: TextStyle(fontSize: 14.0,color: Colors.grey[600]),
                              softWrap: true),
                          Container(height: 10.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("查看详情", style: TextStyle(fontSize: 14.0,color: Colors.blue[600])),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ))
          )).values.toList(),
        ),
      );
    }

    //下拉刷新
    void _onRefresh() async {
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              OverAllHomeWidget(this.widget.overAll),
              Container(height: 15.0, color: Colors.grey[200]),
              titleWidget("防护知识合辑"),
              _buildRecommend(this.widget.recommendList),
              titleWidget("实时播报"),
              newsWidget,
              titleWidget("疾病知识"),
              _buildWiki(this.widget.wikiList),
            ],
          ),
        ));
  }
}

String getTimeStr(int pubDate) {
  DateTime nowTimeStr = DateTime.now();
  DateTime pubTimeStr = DateTime.fromMillisecondsSinceEpoch(pubDate);
  List<String> timeList =
      nowTimeStr.difference(pubTimeStr).toString().split(":");
  return timeList[0] == "0"
      ? timeList[1] + "分钟前"
      : timeList[0] + "小时" + timeList[1] + "分钟前";
}

//带底色最新图标
Widget textWidget(var text, Color color) {
  return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(2.0))),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      margin: EdgeInsets.only(right: 4.0));
}

Widget _getRow(News news, bool topNews, BuildContext context) {
  //跟进记录
  Widget contentWidget = Card(
      elevation: 1.0, //阴影
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  topNews ? textWidget("最新", Colors.red[600]) : Container(),
                  Expanded(
                    child: Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              )),
              Container(
                child: Text(
                  news.summary ?? "--",
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  softWrap: true,
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  "信息来源：" + news.infoSource,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  softWrap: true,
                ),
              )
            ],
          )));

  Widget timeRow = Row(
    children: <Widget>[
      Text(getTimeStr(news.pubDate),
          style: TextStyle(
            fontSize: 13.0,
          ))
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
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            title: news.title, url: news.sourceUrl)));
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
