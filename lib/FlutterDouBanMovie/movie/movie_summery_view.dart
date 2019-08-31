

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieSummaryView extends StatelessWidget {
  final String summary;
  final bool isUnfold;
  final VoidCallback onPressed;

  MovieSummaryView(this.summary, this.isUnfold, this.onPressed);

//  @override
  Widget build(BuildContext context) {
    return summary == null
        ? new Center(child: CupertinoActivityIndicator())
        : Container(
          padding: EdgeInsets.only(top:5.0,right: 10.0,left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                summary,
                style: TextStyle(
                  fontSize: 14.0,
                ),
                maxLines: isUnfold ? null : 4,
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(isUnfold ? '收起' : '显示全部', style:TextStyle(fontSize: 14.0)),
                    Icon(isUnfold ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ],
          ),
    );
  }
}