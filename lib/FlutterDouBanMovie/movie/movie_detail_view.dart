import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/DouBanListView.dart';

class MovieDetailView extends StatelessWidget {
  var title;
  var start;
  var year;
  var subject;
  MovieDetailView(this.title,this.start,this.year,this.subject);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            title + ' (' + year + ')',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RatingBar(start,18.0,Colors.grey),
          ],
        ),
        new Container(
          margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 5.0),
          child: DescWidget(subject),
        )
      ],
    );
  }
}