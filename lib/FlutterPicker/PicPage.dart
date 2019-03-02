
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lake/FlutterPicker/PicView.dart';
import 'package:http/http.dart' as http;

class PicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PicListWidget();
  }
}

class PicListWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PicListWidgetState();
  }
}

class PicListWidgetState extends State<PicListWidget> with SingleTickerProviderStateMixin{

  List<dynamic> data;
  http.Client client;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPic();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (client != null) {
      client.close();
    }
  }

  void loadPic(){
    client = new http.Client();
    client.get("https://m2.qiushibaike.com/article/list/pic").then((response){
      if(response.statusCode == 200){
        dynamic dataList = json.decode(response.body);
        print(response.body);
        data = dataList["items"];
        setState(() {

        });
      }
    }).catchError(dealError)
        .whenComplete((){
      client.close();
    });
  }

  List<Widget> _getChildren(){
    List<Widget> widgets = new List();
    if(data == null){
      widgets.add(new Center(
        child: new Text('正在加载，请稍后'),
      ));
    }else{
      for(var map in data){
        widgets.add(getItemWidget(map));
      }
    }
    return widgets;
  }

  final String defaultThumb = "";
  Widget getItemWidget(Map<String,dynamic> map){
    return new Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                width: 30,
                height: 30,
                child: new ClipOval(
                  child: map["user"] != null && map["user"]["thumb"] != null
                      ? Image.network(map["user"]["thumb"])
                      : Container(),
                ),
              ),
              Text(
                map["user"] != null && map["user"]["login"] != null
                    ? map["user"]["login"]
                    : " ",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              map["content"],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          map["format"] == "multi"
              ? map["attachments"] != null
              ? new Container(
            height: 100,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: getItemPics(map["attachments"]),
            ),
          )
              : new Container(
            width: 0,
            height: 0,
          )
              : new GestureDetector(
            onTap: () {
              lookPic(map["low_url"]);
            },
            child: new Container(
              height: 200.0,
              width: 100.0,
              child: FadeInImage.assetNetwork(
                placeholder: "images/splash.jpg",
                image: map["low_url"],
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          )

        ],
      ),
    );
  }


  //获取图片列表
  List<Widget> getItemPics(List<dynamic> pics){
    print("图片列表：" + pics.toString());
    List<Widget> picsWidgets = new List();
    if (pics != null) {
      for (Map<String, dynamic> map in pics) {
        String url = "https://null";
        print("图片格式:" + map["format"].toString());
        if (map["format"] == "gif") {
          print("zt:image:   " + url);
          url = "https:" + map["pic_url"].toString();
        } else if (map["format"] == "image") {
          url = "https:" + map["low_url"].toString();
        }
        picsWidgets.add(new GestureDetector(
          onTap: () {
            lookPic(url);
          },
          child: new Container(
            margin: EdgeInsets.only(right: 5.0,left: 5.0),
            child: FadeInImage.assetNetwork(
              placeholder: "images/splash.jpg",
              image: url,
              fit: BoxFit.fitHeight,
            ),
          ),
        ));
      }
    } else {
      picsWidgets.add(new Container(
        width: 0,
        height: 0,
      ));
    }
    return picsWidgets;
  }

  void lookPic(String url) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new PicView(url)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: new ListView(
        children: _getChildren(),
      ),
    );
  }

  dealError(dynamic error) {
    print(error.toString());
  }
}
