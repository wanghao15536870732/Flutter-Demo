
import 'package:flutter/cupertino.dart';

class PicView extends StatelessWidget {

  String pic;

  PicView(this.pic);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: new Container(
        child: FadeInImage.assetNetwork(
            placeholder: "images/pull.png", image: pic),
      ),
    );
  }
}
