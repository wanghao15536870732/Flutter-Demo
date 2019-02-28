
class WeekData{
  List<dynamic> code;  //对应天气代码
  List<dynamic> data;   //日期‘
  List<dynamic> weather;  //天气
  List<dynamic> ltempture;  //最低温度
  List<dynamic> htempture;  //最高温度
  List<dynamic> winddir; //风向
  List<dynamic> windsc; //风速
  List<dynamic> code_n;  //夜间天气代码
  List<dynamic> weather_n;  //夜间天气

  WeekData({
    this.code,
    this.data,
    this.weather,
    this.ltempture,
    this.htempture,
    this.winddir,
    this.windsc,
    this.code_n,
    this.weather_n,
  });

  /**
   * {"
   * cond_code_d":"101",
   * "cond_code_n":"104",
   * "cond_txt_d":"多云",
   * "cond_txt_n":"阴",
   * "date":"2019-02-25",
   * "hum":"44",
   * "mr":"00:00",
   * "ms":"10:43",
   * "pcpn":"0.0",
   * "pop":"6",
   * "pres":"911",
   * "sr":"07:05",
   * "ss":"18:20",
   * "tmp_max":"9",
   * "tmp_min":"-2",
   * "uv_index":"0",
   * "vis":"24",
   * "wind_deg":"157",
   * "wind_dir":"东南风",
   * "wind_sc":"1-2",
   * "wind_spd":"9"}
   */

  factory WeekData.fromJson(Map<String,dynamic> json){
    return frommap(json);
  }

  static WeekData frommap(Map map){
    List week = map['HeWeather6'][0]['daily_forecast'];

    List weekcode = [];
    List weekdata = [];
    List weekweather = [];
    List weekltemp = [];
    List weekhtemp = [];
    List weekwinddir = [];
    List weekwinsc = [];
    List weekcode_n = [];
    List weekweather_n = [];

    for(int i = 0;i < week.length;i ++){
      weekcode.add(week[i]['cond_code_d']);
      weekdata.add(week[i]['date']);
      weekweather.add(week[i]['cond_txt_d']);
      weekltemp.add(week[i]['tmp_min']);
      weekhtemp.add(week[i]['tmp_max']);
      weekwinddir.add(week[i]['wind_dir']);
      weekwinsc.add(week[i]['wind_sc']);
      weekcode_n.add(week[i]['cond_code_n']);
      weekweather_n.add(week[i]['cond_txt_n']);
    }

    print(weekcode.toString());
    print(weekdata.toString());
    print(weekweather.toString());
    print(weekltemp.toString());
    print(weekhtemp.toString());
    print(weekwinddir.toString());
    print(weekwinsc.toString());
    print(weekcode_n.toString());
    print(weekweather_n.toString());

    return new WeekData(
      code: weekcode,
      data: weekdata,
      weather: weekweather,
      ltempture: weekltemp,
      htempture: weekhtemp,
      winddir: weekwinddir,
      windsc: weekwinsc,
      code_n: weekcode_n,
      weather_n: weekweather_n,
    );
  }

  factory WeekData.empty(){
    return WeekData(
      code: [],
      data: [],
      weather: [],
      ltempture: [],
      htempture: [],
      winddir: [],
      windsc: [],
      code_n: [],
      weather_n: [],
    );
  }
}