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