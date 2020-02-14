
class DressingData{
  String weatherDet;  //天气详情
  String weatherSug;  //穿衣建议
  String weatherFlu;  //天气流感
  String weatherSpo;  //运动建议
  String weatherTra;  //旅游建议
  String weatherUv;   //紫外线
  String weatherCw;  //洗车
  String weatherAir;  //空气

  DressingData({
    this.weatherAir,
    this.weatherCw,
    this.weatherDet,
    this.weatherFlu,
    this.weatherSpo,
    this.weatherSug,
    this.weatherTra,
    this.weatherUv,
  });

  factory DressingData.fromJson(Map<String,dynamic> json){
    return DressingData(
      weatherDet: json['HeWeather6'][0]['lifestyle'][0]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][0]['txt'],
      weatherSug:  json['HeWeather6'][0]['lifestyle'][1]['brf'] + '  ' + json['HeWeather6'][0]['lifestyle'][1]['txt'],
      weatherFlu:  json['HeWeather6'][0]['lifestyle'][2]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][2]['txt'],
      weatherSpo:  json['HeWeather6'][0]['lifestyle'][3]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][3]['txt'],
      weatherTra:  json['HeWeather6'][0]['lifestyle'][4]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][4]['txt'],
      weatherUv:  json['HeWeather6'][0]['lifestyle'][5]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][5]['txt'],
      weatherCw:  json['HeWeather6'][0]['lifestyle'][6]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][6]['txt'],
      weatherAir:  json['HeWeather6'][0]['lifestyle'][7]['brf'] + '  ' +  json['HeWeather6'][0]['lifestyle'][7]['txt'],
    );
  }

  factory DressingData.empty(){
    return DressingData(
      weatherDet: "",
      weatherSug: "",
      weatherFlu: "",
      weatherSpo: "",
      weatherTra: "",
      weatherUv: "",
      weatherCw: "",
      weatherAir: "",
    );
  }
}