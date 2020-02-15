class OverAll {
  String virus; //病毒
  String infectSource; //传染源
  String passWay; //传播途径
  int currentConfirmedCount; //现存确诊
  int confirmedCount; //累计确诊
  int suspectedCount; //现存疑似
  int seriousCount; //现存重症
  int curedCount; //治愈人数
  int deadCount; //死亡人数
  int currentConfirmedIncr; //较昨日新增现存确诊
  int confirmedIncr; //较昨日新增确诊病例
  int suspectedIncr;  //较昨日新增疑似病例
  int seriousIncr; //较昨日新增重症病例
  int curedIncr; //较昨日新增治愈人数
  int deadIncr; //较昨日新增死亡人数
  String remark1; //易感人群
  String remark2; //潜伏期
  String remark3; //宿主
  String imgUrl; //全国统计图
  List<TrendChart> countryTrendChart; //全国 疫情图表
  List<TrendChart> hbFeiHbTrendChart; //湖北/非湖北 疫情图表
  int pubDate; //更新时间
  List<Marquee> marqueeList;

  OverAll({
    this.virus,
    this.infectSource,
    this.passWay,
    this.currentConfirmedCount,
    this.confirmedCount,
    this.suspectedCount,
    this.seriousCount,
    this.curedCount,
    this.deadCount,
    this.currentConfirmedIncr,
    this.confirmedIncr,
    this.suspectedIncr,
    this.seriousIncr,
    this.curedIncr,
    this.deadIncr,
    this.remark1,
    this.remark2,
    this.remark3,
    this.imgUrl,
    this.countryTrendChart,
    this.hbFeiHbTrendChart,
    this.pubDate,
    this.marqueeList,
  });

  factory OverAll.fromJson(Map data) {
    return OverAll(
      virus: data['note1'],
      infectSource: data['note2'],
      passWay: data['note3'],
      currentConfirmedCount: data['currentConfirmedCount'],
      confirmedCount: data['confirmedCount'],
      suspectedCount: data['suspectedCount'],
      seriousCount: data['seriousCount'],
      curedCount: data['curedCount'],
      deadCount: data['deadCount'],
      currentConfirmedIncr: data['currentConfirmedIncr'],
      confirmedIncr: data['confirmedIncr'] == null ? 0 : data['confirmedIncr'],
      suspectedIncr: data['suspectedIncr'] == null ? 0 : data['suspectedIncr'],
      seriousIncr: data['seriousIncr'] == null ? 0 : data['seriousIncr'],
      curedIncr: data['curedIncr'] == null ? 0 : data['curedIncr'],
      deadIncr: data['deadIncr'] == null ? 0 : data['deadIncr'],
      remark1: data['remark1'],
      remark2: data['remark2'],
      remark3: data['remark3'],
      imgUrl: data['imgUrl'],
      countryTrendChart: TrendChartList.fromJson(data['quanguoTrendChart']).trendChatList,
      hbFeiHbTrendChart: TrendChartList.fromJson(data['hbFeiHbTrendChart']).trendChatList,
      pubDate: data['modifyTime'],
      marqueeList: MarqueeList.fromJson(data['marquee']).marqueeList,
    );
  }

  factory OverAll.empty(){
    return OverAll(
      virus: '',
      infectSource: '',
      passWay: '',
      confirmedCount: 0,
      suspectedCount: 0,
      seriousCount: 0,
      curedCount: 0,
      deadCount: 0,
      confirmedIncr: 0,
      suspectedIncr: 0,
      seriousIncr: 0,
      curedIncr: 0,
      deadIncr: 0,
      remark1: '',
      remark2: '',
      remark3: '',
      imgUrl: '',
      countryTrendChart: [],
      hbFeiHbTrendChart: [],
      pubDate: 0,
      marqueeList: [],
    );
  }
}

class MarqueeList{
  List<Marquee> marqueeList;
  MarqueeList(this.marqueeList);
  MarqueeList.fromJson(List data) {
    marqueeList = [];
    for(var i = 0;i < data.length;i ++){
      marqueeList.add(Marquee.fromJson(data[i]));
    }
  }
}

class Marquee{
  int id;
  String marqueeLabel;
  String marqueeContent;
  String marqueeLink;

  Marquee(this.id,this.marqueeLabel,this.marqueeContent,this.marqueeLink);

  Marquee.fromJson(Map data) {
    id = data['id'];
    marqueeLabel = data['marqueeLabel'];
    marqueeContent = data['marqueeContent'];
    marqueeLink = data['marqueeLink'];
  }
}

class TrendChartList{
  List<TrendChart> trendChatList;
  TrendChartList(this.trendChatList);
  TrendChartList.fromJson(List data){
    trendChatList = [];
    for(var i = 0;i < data.length;i ++){
      trendChatList.add(TrendChart.fromJson(data[i]));
    }
  }
}

class TrendChart{
  String title;
  String imgUrl;
  TrendChart(this.title,this.imgUrl);

  TrendChart.fromJson(Map data){
    title = data['title'];
    imgUrl = data['imgUrl'];
  }
}

