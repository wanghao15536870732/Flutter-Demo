class OverAll {
  String virus; //病毒
  String infectSource; //传染源
  String passWay; //传播途径
  int confirmedCount; //确诊病例
  int suspectedCount; //疑似病例
  int curedCount; //治愈人数
  int deadCount; //死亡人数
  String remark1; //易感人群
  String remark2; //潜伏期
  String dailyPic; //疫情地图
  String pubDate; //更新时间

  OverAll({
    this.virus,
    this.infectSource,
    this.passWay,
    this.confirmedCount,
    this.suspectedCount,
    this.curedCount,
    this.deadCount,
    this.remark1,
    this.remark2,
    this.dailyPic,
    this.pubDate,
  });

  factory OverAll.fromJson(Map data) {
    return OverAll(
      virus: data['virus'],
      infectSource: data['infectSource'],
      passWay: data['passWay'],
      confirmedCount: data['confirmedCount'],
      suspectedCount: data['suspectedCount'],
      curedCount: data['curedCount'],
      deadCount: data['deadCount'],
      remark1: data['remark1'],
      remark2: data['remark2'],
      dailyPic: data['dailyPic'],
      pubDate: DateTime.fromMillisecondsSinceEpoch(data['updateTime']).toString(),
    );
  }
}
