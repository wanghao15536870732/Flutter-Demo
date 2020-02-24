import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "123",
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
