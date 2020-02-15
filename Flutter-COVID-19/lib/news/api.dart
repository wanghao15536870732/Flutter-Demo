import 'dart:convert';

import 'package:flutter_app/news/news.dart';
import 'package:flutter_app/overall/over_all.dart';
import 'package:flutter_app/provinces/country.dart';
import 'package:http/http.dart' as http;

class API{
  static String baseUrl = "https://lab.isaaclin.cn/nCoV/api/";
  static String host = "http://49.232.173.220:3001/";
  static String overallUrl = host + "data/getStatisticsService"; //整体统计信息
  static String recommendUrl = host + "data/getIndexRecommendList"; //最新防护知识
  static String rumorUrl = host + "data/getIndexRumorList"; //最新辟谣
  static String wikiUrl = host + "data/getWikiList"; //最新知识百科

  static String newsUrl = baseUrl + "news";  //新闻数据前十条
  static String allNewsUrl = newsUrl + "?num=20";

  static String areaUrl = "https://api.yimian.xyz/coro";  //地区

  //整体统计信息
  static Future<OverAll> requestOverall() async{
    final overallResponse = await http.get(overallUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> overallData = json.decode(utf8decoder.convert(overallResponse.bodyBytes));
    OverAll overAll = OverAll.fromJson(overallData);
    return overAll;
  }

  //最新防护知识
  static Future<List<Recommend>> requestRecommend() async{
    final recommendResponse = await http.get(recommendUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    List<dynamic> recommendData = json.decode(utf8decoder.convert(recommendResponse.bodyBytes));
    List<Recommend> recommendList = RecommendList.fromJson(recommendData).recommendList;
    return recommendList;
  }

  //最新知识百科
  static Future<List<Wiki>> requestWiki() async{
    final wikiResponse = await http.get(wikiUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> wikiData = json.decode(utf8decoder.convert(wikiResponse.bodyBytes));
    List<Wiki> wikiList = WikiList.fromJson(wikiData['result']).wikiList;
    return wikiList;
  }

  //最新辟谣
  static Future<List<Rumor>> requestRumors() async{
    final rumorsResponse = await http.get(rumorUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    List<dynamic> rumorsData = json.decode(utf8decoder.convert(rumorsResponse.bodyBytes));
    List<Rumor> rumorList = RumorsList.fromJson(rumorsData).rumorList;
    return rumorList;
  }

  //新闻
  static Future<List<News>> requestNews(bool all) async {
    final newsResponse = await http.get(all ? allNewsUrl : newsUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> newsData = json.decode(utf8decoder.convert(newsResponse.bodyBytes));
    List<News> newsList = NewsList.fromJson(newsData['results']).newsList;
    return newsList;
  }

  //地区
  static Future<List<Province>> requestProvince() async{
    final areaResponse = await http.get(areaUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    List<dynamic> areaData = json.decode(utf8decoder.convert(areaResponse.bodyBytes));
    List<Province> areaDataList = ProvinceList.fromJson(areaData).provinceList;
    return areaDataList;
  }

  //全球地区
  static Future<List<Country>> requestCountry() async{
    final areaResponse = await http.get(areaUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    List<dynamic> areaData = json.decode(utf8decoder.convert(areaResponse.bodyBytes));
    List<Country> countryDataList = CountryList.fromJson(areaData).countryList;
    return countryDataList;
  }
}