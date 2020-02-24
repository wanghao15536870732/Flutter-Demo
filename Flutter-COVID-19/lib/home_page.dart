import 'package:flutter/material.dart';
import 'package:flutter_app/news/api.dart';
import 'package:flutter_app/news/news.dart';
import 'package:flutter_app/news/rumor_home_page.dart';
import 'package:flutter_app/overall/over_all.dart';
import 'package:flutter_app/provinces/country.dart';
import 'package:flutter_app/provinces/state_province_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'carousel/SearchDelegate.dart';
import 'news/news_home_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<News> newsList = [];
  List<Rumor> rumorList = [];
  List<Province> provinceList = [];
  List<Country> countryList = [];
  List<Recommend> recommendList = [];
  List<Wiki> wikiList = [];
  OverAll overAll = OverAll.empty();

  @override
  void initState() {
    super.initState();
    requestPermission(); //申请权限
    requestData();  //请求数据
  }

  Future requestPermission() async{
    Map<PermissionGroup, PermissionStatus> permissions = await
      PermissionHandler().requestPermissions([PermissionGroup.location,PermissionGroup.storage]);
    for(var i = 0;i < permissions.length;i ++){
      if(permissions[i] != PermissionStatus.granted){
        print("有权限未开启");
        // bool isOpened = await PermissionHandler().openAppSettings();  //打开设置
      }else{
        print("权限均已开启");
      }
    }
  }

  Future requestData() async {
    OverAll overAll = await API.requestOverall();
    List<News> newsList = await API.requestNews(false);
    List<Recommend> recommendList = await API.requestRecommend();
    List<Rumor> rumorList = await API.requestRumors();
    List<Province> provinceList = await API.requestProvince();
    List<Country> countryList = await API.requestCountry();
    List<Wiki> wikiList = await API.requestWiki();
    setState(() {
      this.newsList = newsList;
      this.overAll = overAll;
      this.recommendList = recommendList;
      this.rumorList = rumorList;
      this.provinceList = provinceList;
      this.countryList = countryList;
      this.wikiList = wikiList;
    });
  }

  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("全国新型肺炎疫情实时动态"),
        actions: <Widget>[
          IconButton(icon:  Icon(Icons.search,color: Colors.white), onPressed: (){
            showSearch(context: context, delegate: SearchBarDelegate(this.provinceList));
          }),
        ],
      ),
      body: new PageView.builder(
        onPageChanged:_pageChange,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          if(index == 0){
            return NewsHomePage(newsList: newsList,overAll: overAll,
              recommendList: recommendList,wikiList: wikiList,);
          }else if(index == 1){
            return ExpansionPanelPage(provinceList: provinceList,countryList: countryList);
          }else{
            return RumorHomePage(rumorList: rumorList);
          }
        },
        itemCount: 3,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.whatshot), title: new Text("实时疫情")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.map), title: new Text("疫情地图")),
          BottomNavigationBarItem(
            icon: new Icon(Icons.sms_failed),title: new Text("谣言与防护")),
        ],
        currentIndex: _currentPageIndex,
        onTap: (int index){
          //_pageController.jumpToPage(index); 没有动画的页面切换
          _pageController.animateToPage(index, duration: new Duration(seconds: 2),curve:new ElasticOutCurve(0.8));
          _pageChange(index);
        },
      ),
    );
  }
}
