import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/carousel/carousel.dart';
import 'package:flutter_app/news/source_webview.dart';
import 'package:flutter_app/overall/over_all.dart';

class OverAllHomeWidget extends StatelessWidget {

  final OverAll overAll;

  OverAllHomeWidget(this.overAll);

  @override
  Widget build(BuildContext context) {
    Widget itemWidget(String number, int numberInc, String title,
        Color color) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Text(
                  '较昨日',
                  style: TextStyle(fontSize: 9.0, color: Colors.grey[700]),
                ),
                Text(
                  numberInc > 0 ? "+" + numberInc.toString() : numberInc.toString(),
                  style: TextStyle(
                      fontSize: 9.0, color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Text(
              number,
              style: TextStyle(
                  fontSize: 19.0, color: color, fontWeight: FontWeight.bold),
            ),
            new Text(
              title,
              style: TextStyle(fontSize: 13.0, color: Colors.black),
            )
          ],
        ),
      );
    }

    //带底色最新图标
    Widget textWidget(var text) {
      return Container(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(2.0))),
          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
          margin: EdgeInsets.only(right: 4.0)
      );
    }

    Widget marqueeWidgetItem(Marquee marquee) {
      return Container(
        height: 60.0,
        color: Colors.grey[200],
        child: Card(
            margin: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            child: GestureDetector(
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: textWidget(marquee.marqueeLabel),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(marquee.marqueeContent,
                                style: TextStyle(fontSize: 15.0)),
                          ),
                        ],
                      )
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Icon(
                          Icons.keyboard_arrow_right, color: Colors.grey),
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        WebViewPage(title: marquee.marqueeLabel,
                            url: marquee.marqueeLink)));
              },
            )
        ),
      );
    }

    Widget marqueeWidget(List<Marquee> marquees) {
      List<Widget> marqueeWidgets = [];
      for (int i = 0; i < marquees.length; i ++) {
        marqueeWidgets.add(marqueeWidgetItem(marquees[i]));
      }
      return Column(
        children: marqueeWidgets,
      );
    }

    Widget firstWidget = Container(
        child: new Column(
          children: <Widget>[
            overAll.marqueeList.length == 0 ? Container() : marqueeWidget(
                overAll.marqueeList),
            Container(
              margin: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
              alignment: Alignment.topLeft,
              child: Text(
                "截止 " + DateTime.fromMillisecondsSinceEpoch(overAll.pubDate)
                    .toString()
                    .substring(0, 19) + " 全国数据统计",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                itemWidget(overAll.confirmedCount.toString(),
                  overAll.confirmedIncr, "累计确诊", Colors.red,),
                itemWidget(overAll.suspectedCount.toString(),
                    overAll.suspectedIncr, "现存疑似", Colors.orange),
                itemWidget(overAll.seriousCount.toString(),
                    overAll.seriousIncr, "现存重症", Colors.brown),
                itemWidget(overAll.deadCount.toString(), overAll.deadIncr,
                    "死亡人数", Colors.black54),
                itemWidget(overAll.curedCount.toString(), overAll.curedIncr,
                    "治愈人数", Colors.green),
              ],
            ),
          ],
        )
    );

    Widget remarkWidget(Color color, String markStr) {
      return Container(
        margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 7.0, top: 2.0),
                  child: Icon(
                    Icons.whatshot,
                    color: color,
                    size: 15.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                markStr,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            )
          ],
        ),
      );
    }

    Widget secondWidget = Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          remarkWidget(Colors.red[800], overAll.virus),
          remarkWidget(Colors.red[600], overAll.infectSource),
          remarkWidget(Colors.orange[500], overAll.passWay),
          remarkWidget(Colors.orange[400], overAll.remark1),
          remarkWidget(Colors.orange[300], overAll.remark2),
          remarkWidget(Colors.orange[200], overAll.remark3),
        ],
      ),
    );

    Widget thirdWidget(String title,List<TrendChart> charts) {
      return Container(
        margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5.0,left: 15.0),
              child: Row(
                children: <Widget>[
                  Text(title,textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: 16.0))
                ],
              ),
            ),
            Carousel(chartList: charts),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          firstWidget,
          dividerWidget,
          secondWidget,
          Container(height: 15.0, color: Colors.grey[200]),
          titleWidget("疫情地图"),
          new Divider(height: 2.0, color: Colors.grey),
          thirdWidget("全国",overAll.countryTrendChart),
          thirdWidget("湖北/非湖北",overAll.hbFeiHbTrendChart),
        ],
      ),
    );
  }
}

Widget titleWidget(String title) {
  return Container(
    height: 40.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Container(
              height: 15.0,
              width: 5.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
            )
        ),
        Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(title, style: TextStyle(fontSize: 18.0, color: Colors.black))
        ),
      ],
    ),
  );
}

Widget dividerWidget = Container(
  margin: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0, right: 15.0),
  child: new Divider(
    height: 2.0,
    color: Colors.grey,
  ),
);