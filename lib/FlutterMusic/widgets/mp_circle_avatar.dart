import 'dart:io';
import 'package:flutter/material.dart';

Widget avatar(File f, String title, MaterialColor color) {
  return new Material(

    borderRadius: new BorderRadius.circular(20.0),
    elevation: 3.0,
    child: f != null
        ? new CircleAvatar(
            child: new Image.file(
              f,
              fit: BoxFit.contain,
            ),
            minRadius: 23.0,
            maxRadius: 25.0,
        )
        : new CircleAvatar(
            child: new Icon(
            Icons.play_arrow,
              color: Colors.white,
           ),
      backgroundColor: color,
    ),
  );
}