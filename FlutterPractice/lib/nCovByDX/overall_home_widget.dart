import 'package:flutter/material.dart';
import 'OverAll.dart';

class OverAllHomeWidget extends StatelessWidget {

  OverAll overAll;

  OverAllHomeWidget(this.overAll);

  @override
  Widget build(BuildContext context) {

    Widget itemWidget(String number,String title,Color color) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              number,
              style: TextStyle(fontSize: 19.0, color: color,fontWeight: FontWeight.bold),
            ),
            new Text(
              title,
              style: TextStyle(fontSize: 13.0, color: Colors.black),
            )
          ],
        ),
      );
    }

    Widget remarkWidget(Color color,String markStr){
      return Container(
        margin: EdgeInsets.only(top:3.0,bottom: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15.0,right: 7.0,top: 2.0),
                  child:  Icon(
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

    Widget firstWidget = Container(
      margin: EdgeInsets.only(bottom: 10.0
      ),
      child: new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.0,bottom: 10.0),
            alignment: Alignment.topLeft,
            child: Text(
              "截止 " + overAll.pubDate + " 全国数据统计",
              style: TextStyle(color: Colors.grey,fontSize: 12.0),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              itemWidget(overAll.confirmedCount.toString(),"确诊病例",Colors.red,),
              itemWidget(overAll.suspectedCount.toString(),"疑似病例",Colors.orange),
              itemWidget(overAll.deadCount.toString(),"死亡人数",Colors.black38),
              itemWidget(overAll.curedCount.toString(),"治愈人数",Colors.green),
            ],
          ),
        ],
      )
    );

    Widget secondWidget = Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          remarkWidget(Colors.red[800],overAll.virus),
          remarkWidget(Colors.red[600],overAll.infectSource),
          remarkWidget(Colors.orange[400],overAll.passWay),
          remarkWidget(Colors.orange[300],overAll.remark1),
          remarkWidget(Colors.orange[200],overAll.remark2),
        ],
      ),
    );

    Widget decorateWidget = Container(
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration:BoxDecoration(
            border:Border.all(color: Colors.grey[600],width: 400.0)
        ),
      ),
    );

    Widget imageWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            margin: EdgeInsets.only(top: 20.0,left: 15.0,bottom: 20.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  overAll.dailyPic,
                  fit: BoxFit.fill,
                  height: 700.0,
                  width: constraints.constrainWidth(),
                ),
              ],
            ),
          ),
        );
      },
    );

    return new Container(
      child: Column(
        children: <Widget>[
          firstWidget,
          secondWidget,
          imageWidget,
          //decorateWidget
        ],
      ),
    );
  }
}