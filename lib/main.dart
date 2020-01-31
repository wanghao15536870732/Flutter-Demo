import 'package:demoflutter/route.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'EnglishWords/word.dart';
import 'FlutterCalculator/calculator.dart';
import 'FlutterDouBanMovie/HomeMovie.dart';
import 'FlutterMusic/music.dart';
import 'FlutterWeather/weather.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'nCovByDX/news/news_home_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(fontSize: 18.0,color: Colors.white),
      backgroundColor: Colors.grey.withAlpha(200),
      radius: 8.0,
      child: MaterialApp(
        title: 'Fluter UI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo',),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [,,bvn,
          const Locale('zh','CH'),
          const Locale('en','US'),
        ],
        routes: {
          UIRoute.flutterWord:(_) => Word(),
          UIRoute.flutterWeather:(_) => Weather(),
          UIRoute.flutterCalculator:(_) => Calculator(),
          UIRoute.flutterMusic:(_) => MusicPage(),
          UIRoute.flutterMovie:(_) => MovieHome(),
          UIRoute.flutterNCov:(_) => NewsHomePage(title: "全国新型肺炎疫情实时动态"),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key,this.title}):super(key:key);

  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  Future requestPermission() async {

  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            child: AppBar(
              title: Text(widget.title),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.white,
                  ],
                )
            ),
          ),
          preferredSize:
          new Size(MediaQuery.of(context).size.width, kToolbarHeight)
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blueAccent,
              ],
            ),
          ),
          child: ListView.builder(
            itemBuilder: (context,index){
              return _MenuDataItem(menus[index]);
            },
            itemCount: menus.length,
          ),
        ),
      ),
    );
  }
}

class _MenuDataItem extends StatelessWidget{

  const _MenuDataItem(this.data);

  final double height = 80.0;

  final _MenuData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.of(context).pushNamed(data.routeName);
      },
      child: Container(
        height: height,
        margin: EdgeInsets.fromLTRB(10.0,4.0,10.0,4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    data.icon,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Center(
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _MenuData{

  const _MenuData({
    this.title,
    this.icon,
    this.routeName
  });

  final String title;
  final IconData icon;
  final String routeName;
}


final List<_MenuData> menus = [
  const _MenuData(
    title: 'Flutter Word',
    icon: Icons.language,
    routeName: UIRoute.flutterWord,
  ),
  const _MenuData(
    title:'Flutter Weather',
    icon: Icons.ac_unit,
    routeName: UIRoute.flutterWeather,
  ),
  const _MenuData(
    title: 'Flutter Calculator',
    icon: Icons.add,
    routeName: UIRoute.flutterCalculator,
  ),
  const _MenuData(
    title: 'Flutter Music',
    icon: Icons.music_note,
    routeName: UIRoute.flutterMusic,
  ),
  const _MenuData(
    title: 'Douban Movie',
    icon: Icons.movie,
    routeName: UIRoute.flutterMovie,
  ),
  const _MenuData(
    title: 'Sars Dynamic',
    icon: Icons.whatshot,
    routeName: UIRoute.flutterNCov,
  )
];