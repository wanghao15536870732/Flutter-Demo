import 'package:demoflutter/FlutterDouBanMovie/DouBanListView.dart';
import 'package:demoflutter/FlutterDouBanMovie/model/movie_actor_work.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActorDetailWorks extends StatelessWidget{

  final List<MovieActorWork> works;
  const ActorDetailWorks(this.works);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "影视作品",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          SizedBox.fromSize(
            size: Size.fromHeight(200),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: works.length,
                itemBuilder: (BuildContext context,int index){
                  return _buildWorks(context, index);
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorks(BuildContext context,int index){
    double width = 90;
    MovieActorWork work = works[index];
    double paddingRight = 0;
    if(index == works.length - 1){
      paddingRight = 15;
    }
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: paddingRight),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ClipRRect(
                child: Image(
                  image: NetworkImage(work.movie.images.small),
                  fit: BoxFit.cover,
                  width: width,
                  height: width / 0.65,
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            ),
            SizedBox(height: 5.0,),
            Text(
              work.movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0,color: Colors.black),
              maxLines: 1,
            ),
            SizedBox(height: 3.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RatingBar(work.movie.rating.average,12.0,Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }
}