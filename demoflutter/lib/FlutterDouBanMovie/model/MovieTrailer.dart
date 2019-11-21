
class MovieTrailerList{
  List<MovieTrailer> trailers;
  MovieTrailerList(this.trailers);

  MovieTrailerList.fromJson(List data) {
    trailers = [];
    for(var i = 0;i < data.length;i ++){
      trailers.add(MovieTrailer.fromJson(data[i]));
    }
  }
}

class MovieTrailer {
  String cover;
  String trailerUrl;
  String id;

  MovieTrailer(this.cover, this.id, this.trailerUrl);

  MovieTrailer.fromJson(Map data) {
    cover = data['medium'];
    trailerUrl = data['resource_url'];
    id = data['id'];
  }
}