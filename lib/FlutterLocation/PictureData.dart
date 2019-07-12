

class PictureData{
  String url;
  PictureData(this.url);


  factory PictureData.fromJson(Map<String,dynamic> json){
    return frommap(json);
  }


  static PictureData frommap(Map map) {
    String URL = map[''];

  }
}