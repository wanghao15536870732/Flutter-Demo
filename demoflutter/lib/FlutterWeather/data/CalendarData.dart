class CalendarData{
  final String date;
  final int code;
  final int weekDay;
  final String yearTips;
  final String typeDes;
  final String chineseZodliaz;
  final String solarTerms;
  final String avoid;
  final String lunarCalendar;
  final String suit;
  final int dayOfYear;
  final int weekOfYear;

  CalendarData({
    this.date,
    this.code,
    this.weekDay,
    this.yearTips,
    this.typeDes,
    this.chineseZodliaz,
    this.solarTerms,
    this.avoid,
    this.lunarCalendar,
    this.suit,
    this.dayOfYear,
    this.weekOfYear,
  });

  factory CalendarData.fromJson(Map<String,dynamic> json){
    return CalendarData(
      date: json['data']['date'],
      code: json['code'],
      weekDay: json['data']['weekDay'],
      yearTips: json['data']['yearTips'],
      typeDes: json['data']['typeDes'],
      chineseZodliaz: json['data']['chineseZodiac'],
      solarTerms: json['data']['solarTerms'],
      avoid: json['data']['avoid'],
      lunarCalendar: json['data']['lunarCalendar'],
      suit: json['data']['suit'],
      dayOfYear: json['data']['dayOfYear'],
      weekOfYear: json['data']['weekOfYear'],
    );
  }

  factory CalendarData.empty(){
    return CalendarData(
      date: "",
      code: 0,
      weekDay: 0,
      yearTips: "",
      typeDes: "",
      chineseZodliaz: "",
      solarTerms: "",
      avoid: "",
      lunarCalendar: "",
      suit: "",
      dayOfYear: 0,
      weekOfYear: 0,
    );
  }
}