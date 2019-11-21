
// 电影简介
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_image.dart';
import 'package:flutter_demo/FlutterDouBanMovie/model/movie_rate.dart';

class MovieItem{
  MovieRate rating;
  String title;
  String year;
  MovieImage images;
  String id;

  MovieItem({
    this.title,
    this.year,
    this.images,
    this.id,
    this.rating,
  });
  MovieItem.fromJson(Map data) {
    id = data['id'];
    images = MovieImage.fromJson(data['images']);
    year = data['year'];
    title = data['title'];
    rating = MovieRate.fromJson(data['rating']);
  }
}