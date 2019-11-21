import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_actor_detail.dart';
import 'dart:ui' as ui;

class ActorDetailHeader extends StatelessWidget{

  final MovieActorDetail actorDetail;
  final Color coverColor;
  ActorDetailHeader(this.actorDetail, this.coverColor);
  //获取屏幕高度跟宽度
  double width = MediaQueryData.fromWindow(ui.window).size.width;
  double height = MediaQueryData.fromWindow(ui.window).padding.top;

  String getProfessions(List<String> professions){
    StringBuffer sb = new StringBuffer();
    for(var i = 0;i < professions.length;i ++){
      if(professions[i] != "") {
        sb.write(professions[i]);
        sb.write(" / ");
      }
    }
    return sb.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: NetworkImage(actorDetail.photos.length == 0 ? actorDetail.avatars.large :actorDetail.photos[0].image),
          fit: BoxFit.cover,
          width: width,
          height: 228.0 + height,
        ),
        Opacity( //设置透明度
          opacity: 0.4,
          child: Container(color: coverColor, width: width, height: 218.0 + height),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
              width: width,
              height: 218.0 + height,
              padding:
              EdgeInsets.fromLTRB(30, 34 + height, 10, 20),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Hero(
                      tag: actorDetail.id,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(actorDetail.avatars.large),
                        radius: 50.0,
                      ),
                  ),
                  SizedBox(height: 10,),
                  Text(actorDetail.name, style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70,)),
                  actorDetail.professions.length > 0 ?
                  Text(
                    getProfessions(actorDetail.professions),
                    style:TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    )) : null,
                ],
              )),
        ),
      ],
    );
  }
}