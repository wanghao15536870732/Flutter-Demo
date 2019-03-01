
class CityData{
  String cityName; //城市名

  CityData(this.cityName); //相当于Android里面的构造器
}

class CityList{

  List<dynamic> citys;
  List<dynamic> citynames;

  CityList({
    this.citys,
    this.citynames,
  });

  factory CityList.fromJson(Map<String,dynamic> json){
    return frommap(json);
  }

  static CityList frommap(Map map){
    List city = map['HeWeather6'][0]['basic'];
    
    List citylist = [];
    List names = [];
    
    for(int i = 0;i < city.length;i ++){
      citylist.add(city[i]['location'] + '  ' + city[i]['parent_city'] + '  ' + city[i]['admin_area'] + '  ' + city[i]['cnty']);
      names.add(city[i]['location']);
    }

    print(citylist);
    return new CityList(
      citys: citylist,
      citynames: names,
    );
  }

  factory CityList.empty(){
    return CityList(
      citys: [],
      citynames: [],
    );
  }
}