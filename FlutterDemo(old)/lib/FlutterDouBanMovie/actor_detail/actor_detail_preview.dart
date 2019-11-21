import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ActorDetailPreview extends StatelessWidget{

  final String imageUrl;
  final int index;

  const ActorDetailPreview({Key key, this.imageUrl, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
          children: <Widget>[
            new Hero(
                tag: 'actor$index',
                child: new Image(
                  image: NetworkImage(imageUrl),
                  width: MediaQueryData.fromWindow(ui.window).size.width,
                  height: MediaQueryData.fromWindow(ui.window).size.height,
                )
            ),
            new Stack(
              children: <Widget>[
                Container(
                  width: 44,
                  height: MediaQueryData.fromWindow(ui.window).padding.top + kToolbarHeight,
                  padding: EdgeInsets.fromLTRB(5,MediaQueryData.fromWindow(ui.window).padding.top, 0, 0),
                  child: GestureDetector(onTap:(){ Navigator.pop(context);},child:Icon( Icons.arrow_back,color: Colors.black,)),
                )
              ],
            ),
          ],
        ),
    );
  }
}