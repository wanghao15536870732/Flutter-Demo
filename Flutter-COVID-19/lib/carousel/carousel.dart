import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/overall/over_all.dart';

class Carousel extends StatefulWidget {
  final List<TrendChart> chartList;

  const Carousel({Key key, this.chartList}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Carousel> {
  //索引从0开始，因为有增补，所以这里设为1
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  List<String> _images = [];
  List<String> _labels = [];

  @override
  Widget build(BuildContext context) {
    List<TrendChart> chartList = this.widget.chartList;
    _images.clear();
    _labels.clear();
    for(int i = 0;i < chartList.length;i ++){
      _images.add(chartList[i].imgUrl);
      _labels.add(chartList[i].title);
    }
    List addedImages = [];
    if (_images.length > 0) {
      addedImages..addAll(_images);
    }
    return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.83,
                child: _images.length > 0 ? PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentIndex = page;
                    });
                  },
                  children: addedImages.map((item) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: item,
                        placeholder: (context, url) => CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                  )).toList(),
                ) : Container(),
              ),
              Positioned(bottom: 15.0, left: 0, right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _images.asMap().map((i, v) => MapEntry(i,
                      Container(width: 6.0, height: 6.0,
                        margin: EdgeInsets.only(left: 2.0, right: 2.0),
                        decoration: ShapeDecoration(
                            color: _currentIndex == i
                                ? Colors.red : Colors.grey,
                            shape: CircleBorder()),
                      )))
                      .values.toList(),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
            child: GridView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.35,
              ),
              children: _labels.asMap().map((i,v) => MapEntry(i,
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _currentIndex == i ? Colors.blue[100] : Colors.grey[200],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          _labels[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _currentIndex == i ? Colors.blueAccent : Colors.grey[800],
                            fontSize: 14.0,
                          )
                        ),
                      ),
                    )
                  ),
                  onTap: (){
                    setState(() {
                      _currentIndex = i;
                      _pageController.jumpToPage(_currentIndex);
                    });
                  },
                )
              )).values.toList(),
            )
          )
        ],
      );
  } //
}
