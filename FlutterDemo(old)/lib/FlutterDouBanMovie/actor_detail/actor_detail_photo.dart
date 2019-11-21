
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterDouBanMovie/actor_detail/actor_detail_preview.dart';
import 'package:flutter_demo/FlutterDouBanMovie/actor_detail/actor_detail_view.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/MovieTrailer.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_photo.dart';
import 'package:flutter_demo/FlutterDouBanMovie/movie/movie_play.dart';

class ActorDetailPhoto extends StatelessWidget{
  final List<MovieTrailer> trailers;
  final List<MovieTrailer> bloopers;
  final List<MoviePhoto> photos;
  final String title;
  final String actorId;
  final double horizontal;

  const ActorDetailPhoto({Key key, this.photos, this.actorId, this.title, this.horizontal, this.trailers,this.bloopers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];
    List<Widget> child = [];
    List<Widget> trailerItems =[];

    if(this.trailers.length != 0) {
      for (var i = 0; i < trailers.length; i ++) {
        trailerItems.add(TrailerItem(trailers[i], i, trailers.length));
      }
    }

    if(this.bloopers.length != 0) {
      for (var i = 0; i < bloopers.length; i ++) {
        trailerItems.add(TrailerItem(bloopers[i], i, bloopers.length));
      }
    }

    for(var i = 0; i < photos.length;i ++){
      imageUrls.add(photos[i].image);
    }

    for(var i = 0; i < photos.length;i ++){
      child.add(PhotoItem(photos[i],i,imageUrls,photos.length));
    }
    Widget buildMovieTrailer(){
      return trailers.length == 0 ? new Container() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: horizontal),
            child: Text(
              "预告片 / 花絮",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          SizedBox.fromSize(
            size: Size.fromHeight(140.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: trailerItems,
            ),
          ),
        ],
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildMovieTrailer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: horizontal),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          SizedBox.fromSize(
            size: Size.fromHeight(140.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: child,
            ),
          ),
        ],
      ),
    );
  }
}

class TrailerItem extends StatelessWidget{
  final MovieTrailer trailer;
  int index;
  int length;
  TrailerItem(this.trailer,this.index,this.length);

  @override
  Widget build(BuildContext context) {
    double paddingRight = 0;
    if(index == length - 1){
      paddingRight = 5;
    }
    return GestureDetector(
      onTap: (){
        trailer.trailerUrl != null ? Navigator.push(context,
            MaterialPageRoute(builder: (context) => MoviePlay(videoUrl: trailer.trailerUrl,))): print("$trailer");
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.0,right: paddingRight),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(
                image: NetworkImage(trailer.cover),
                width: 222.0,
                height: 125.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 222.0,
              height: 125.0,
              child: Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class PhotoItem extends StatelessWidget{
  final MoviePhoto photo;
  final int index;
  final List<String> imageUrls;
  final int length;
  const PhotoItem(this.photo,this.index,this.imageUrls, this.length);

  @override
  Widget build(BuildContext context) {
    double paddingRight = 0;
    if(index == length - 1){
      paddingRight = 15;
    }
    return Container(
      margin: EdgeInsets.only(left: 15.0,bottom: 15.0,right: paddingRight),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,MaterialPageRoute(builder: (context) => ActorDetailPreview(imageUrl: imageUrls[index],index: index,)),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Hero(
              tag: 'actor$index',
              child: Image(
                image: NetworkImage(photo.image),
                width: 200.0,
                height: 140.0,
                fit: BoxFit.cover,
              )
          )
        ),
      ),
    );
  }
}