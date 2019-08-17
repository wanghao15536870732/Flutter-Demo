
class SampleData{
  List<String> firsts;
  List<String> lasts;
  List<String> annotation;
  List<String> translations;


  SampleData({
    this.firsts,
    this.lasts,
    this.annotation,
    this.translations,
  });

  factory SampleData.fromJson(Map<String,dynamic> json){
    return fromMap(json);
  }

  static SampleData fromMap(Map map) {
    List data = map['data'];
    List<String> translations = new List();
    List<String> firsts = new List();
    List<String> lasts = new List();
    List<String> annotations = new List();

    for(int i = 0;i < 3;i ++){
      translations.add(data[i]['translation']);
      firsts.add(data[i]['first']);
      lasts.add(data[i]['last']);
      annotations.add(data[i]['annotation']);
    }

    return new SampleData(
      firsts: firsts,
      lasts: lasts,
      annotation: annotations,
      translations:translations,
    );
  }

  factory SampleData.empty(){
    return SampleData(
      firsts: [],
      lasts: [],
      annotation: [],
      translations:[],
    );
  }
}