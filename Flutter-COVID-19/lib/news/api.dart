import 'dart:convert';

import 'package:flutter_app/news/news.dart';
import 'package:flutter_app/overall/over_all.dart';
import 'package:flutter_app/provinces/country.dart';
import 'package:http/http.dart' as http;

class API{
  static String baseUrl = "https://lab.isaaclin.cn/nCoV/api/";
  static String newsUrl = baseUrl + "news";
  static String allNewsUrl = newsUrl + "?num=20";
  static String overallUrl = baseUrl + "overall";
  static String rumorUrl = baseUrl + "rumors";
  static String allRumorUrl = rumorUrl + "?num=20";
  static String areaUrl = "https://api.yimian.xyz/coro";

  //全国统计
  static Future<OverAll> requestOverall() async{
    final overallResponse = await http.get(overallUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> overallData = json.decode(utf8decoder.convert(overallResponse.bodyBytes));
    OverAll overAll = OverAll.fromJson(overallData['results'][0]);
    return overAll;
  }

  //新闻
  static Future<List<News>> requestNews(bool all) async {
    final newsResponse = await http.get(all ? allNewsUrl : newsUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> newsData = json.decode(utf8decoder.convert(newsResponse.bodyBytes));
    List<News> newsList = NewsList.fromJson(newsData['results']).newsList;
    return newsList;
  }

  //谣言
  static Future<List<Rumor>> requestRumors(bool all) async{
    final rumorsResponse = await http.get(all ? allRumorUrl : rumorUrl);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    Map<String,dynamic> rumorsData = json.decode(utf8decoder.convert(rumorsResponse.bodyBytes));
    List<Rumor> rumorList = RumorsList.fromJson(rumorsData['results']).rumorList;
    return rumorList;
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