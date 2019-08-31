//演员详情
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_actor_work.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_image.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_photo.dart';

class MovieActorDetail{
  String name; //姓名
  String nameEn;  //英文姓名
  String gender; //性别
  String summary; //简介
  List<MoviePhoto> photos; //剧照
  String birthday;  //生日
  String birthPlace; //出生地
  String constellation; //星座
  String id; //演员Id
  List professions; //职业
  List<MovieActorWork> works; //演过的电影
  MovieImage avatars; //照片

  MovieActorDetail({
    this.name,
    this.nameEn,
    this.gender,
    this.summary,
    this.photos,
    this.birthday,
    this.birthPlace,
    this.constellation,
    this.id,
    this.professions,
    this.works,
    this.avatars,
  });

  factory MovieActorDetail.fromJson(Map data) {
    return frommap(data);
  }

  static MovieActorDetail frommap(Map map){
    String name = map['name'];
    String nameEn = map['name_en'];
    String gender = map['gender'];
    List professions = map['professions']?.cast<String>()?.toList();
    String summary = map['summary'];
    String bornPlace = map['born_place'];
    String birthday = map['birthday'];
    String constellation = map['constellation'];
    String id = map['id'];
    MovieImage avatars = MovieImage.fromJson(map['avatars']);

    //电影照片
    List<MoviePhoto> photosData = [];
    for (var i = 0; i < map['photos'].length; i++) {
      photosData.add(MoviePhoto.fromJson(map['photos'][i]));
    }

    List<MovieActorWork> worksData = [];
    for (var i = 0; i < map['works'].length; i++) {
      worksData.add(MovieActorWork.fromJson(map['works'][i]));
    }

    return new MovieActorDetail(
      name : name,
      nameEn : nameEn,
      gender : gender,
      summary : summary,
      photos : photosData,
      birthday: birthday,
      birthPlace: bornPlace,
      constellation: constellation,
      id: id,
      professions: professions,
      works: worksData,
      avatars: avatars,
    );
  }

  factory MovieActorDetail.empty(){
    return MovieActorDetail(
      name : "",
      nameEn : "",
      gender : "",
      summary : "",
      photos : [],
      birthday: "",
      birthPlace: "",
      constellation: "",
      id: "",
      professions: [],
      works: [],
      avatars: null,
    );
  }
}