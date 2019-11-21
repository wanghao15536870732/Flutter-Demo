
class MoviePhoto{
  String thumb;
  String image;
  String cover;
  String alt; //照片网页链接
  String id; //照片的id
  String icon;

  MoviePhoto({
    this.thumb,
    this.image,
    this.cover,
    this.alt,
    this.id,
    this.icon
  });

  factory MoviePhoto.fromJson(Map data) {
    return frommap(data);
  }

  static MoviePhoto frommap(Map map){

    String thumb = map['thumb'];
    String image = map['image'];
    String cover = map['cover'];
    String alt = map['alt'];
    String id = map['id'];
    String icon = map['icon'];

    return new MoviePhoto(
      thumb : thumb,
      image : image,
      cover : cover,
      alt : alt,
      id : id,
      icon: icon,
    );
  }

  factory MoviePhoto.empty(){
    return MoviePhoto(
      thumb : "",
      image : "",
      cover : "",
      alt : "",
      id : "",
      icon: "",
    );
  }
}