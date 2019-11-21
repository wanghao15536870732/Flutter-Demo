import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'DouBanListView.dart';
import 'HotListView.dart';
import 'package:http/http.dart' as http;

class MovieHome extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MovieHome> with SingleTickerProviderStateMixin{

  var subjects = [];
  var topSubjects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestMovieTop();
  }

  requestMovieTop() async {
    final response = await http.get(
        "http://api.douban.com/v2/movie/weekly?apikey=0df993c66c0c636e29ecbb5344252a4a");
    final topResponse = await http.get(
        "http://api.douban.com/v2/movie/top250?apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=150");
    Map<String,dynamic> data = json.decode(response.body);
    Map<String,dynamic> result = json.decode(topResponse.body);
    setState(() {
      subjects = data['subjects'];
      topSubjects = result['subjects'];
    });
  }

  @override
  Widget build(BuildContext context) {

    getTop250(var subject1,var subject2,var subject3,String title1,String title2){
      return Container(
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.grey.withOpacity(0.5),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child:new Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.grey.withOpacity(0.7),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        title1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      new Text(
                        title2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 100.0,
                  margin: EdgeInsets.only(left: 15.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(
                            "1." + subject1['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              subject1['rating']['average'].toString(),
                              style: TextStyle(
                                color: Colors.orangeAccent
                              ),
                            ),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text(
                            "2." + subject2['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              subject2['rating']['average'].toString(),
                              style: TextStyle(
                                  color: Colors.orangeAccent
                              ),
                            ),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text(
                            "3." + subject3['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              subject3['rating']['average'].toString(),
                              style: TextStyle(
                                  color: Colors.orangeAccent
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                flex: 3,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(subject1['images']['medium']), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(2.5)),),
        margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
        height: 100.0,
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text("豆瓣榜单"),
      ),
      body: subjects.length == 0
          ? new Center(child: CupertinoActivityIndicator())
          : new Container(
        child: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 1,sigmaY: 1),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new GestureDetector(
                    child: getTop250(subjects[0]['subject'],subjects[1]['subject'],
                      subjects[2]['subject'],"豆瓣周榜","口碑电影",),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new HotMovieList(subjectList: subjects)));
                  },
                ),
                  new GestureDetector(
                    child: getTop250(topSubjects[0],topSubjects[1],topSubjects[2],
                      "TOP 250","豆瓣电影",),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new DouBanListView(subjectList: topSubjects)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}