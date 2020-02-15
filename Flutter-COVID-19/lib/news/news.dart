class NewsList{
  List<News> newsList;
  NewsList(this.newsList);
  NewsList.fromJson(List data) {
    newsList = [];
    for(var i = 0;i < data.length;i ++){
      newsList.add(News.fromJson(data[i]));
    }
  }
}

class News {
  int pubDate;  //发布时间
  String title;  //标题
  String summary;  //摘要
  String infoSource; //来源
  String sourceUrl; //原链接
  String provinceId; //省市编号
  String provinceName; //省市名字

  News(this.pubDate, this.title, this.summary,this.infoSource,
      this.sourceUrl,this.provinceId,this.provinceName);

  News.fromJson(Map data) {
    pubDate = data['pubDate'];
    title = data['title'];
    summary = data['summary'];
    infoSource = data['infoSource'];
    sourceUrl = data['sourceUrl'];
    provinceId = data['provinceId'];
    provinceName = data['provinceName'];
  }
}

class RumorsList{
  List<Rumor> rumorList;
  RumorsList(this.rumorList);
  RumorsList.fromJson(List data){
    rumorList = [];
    for(var i = 0;i < data.length;i ++){
      rumorList.add(Rumor.fromJson(data[i]));
    }
  }
}

class Rumor{
  String title;
  String mainSummary;
  String body;
  int rumorType;
  String sourceUrl;

  Rumor({
    this.title,
    this.mainSummary,
    this.body,
    this.rumorType,
    this.sourceUrl
  });

  factory Rumor.fromJson(Map data){
    return Rumor(
      title: data['title'],
      mainSummary: data['mainSummary'],
      body: data['body'],
      rumorType: data['rumorType'],
      sourceUrl: data['sourceUrl'],
    );
  }
}

class RecommendList{
  List<Recommend> recommendList;
  RecommendList(this.recommendList);
  RecommendList.fromJson(List data){
    recommendList = [];
    for(var i = 0;i < data.length;i ++){
      recommendList.add(Recommend.fromJson(data[i]));
    }
  }
}

class Recommend{
  int createTime;
  int modifyTime;
  String title;
  String imgUrl;
  String linkUrl;
  int contentType;

  Recommend({
    this.createTime,
    this.modifyTime,
    this.title,
    this.imgUrl,
    this.linkUrl,
    this.contentType,
  });

  factory Recommend.fromJson(Map data){
    return Recommend(
      createTime: data['createTime'],
      modifyTime: data['modifyTime'],
      title: data['title'],
      imgUrl: data['imgUrl'],
      linkUrl: data['linkUrl'],
      contentType: data['contentType'],
    );
  }
}

class WikiList{
  List<Wiki> wikiList;
  WikiList(this.wikiList);
  WikiList.fromJson(List data){
    wikiList = [];
    for(var i = 0;i < data.length;i ++){
      wikiList.add(Wiki.fromJson(data[i]));
    }
  }
}

class Wiki{
  String title;
  String imgUrl;
  String linkUrl;
  String description;

  Wiki({
    this.title,
    this.imgUrl,
    this.linkUrl,
    this.description,
  });

  factory Wiki.fromJson(Map data){
    return Wiki(
      title: data['title'],
      imgUrl: data['imgUrl'],
      linkUrl: data['linkUrl'],
      description: data['description'],
    );
  }
}

