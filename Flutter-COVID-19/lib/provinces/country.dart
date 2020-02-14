class ProvinceList{
  List<Province> provinceList;
  ProvinceList(this.provinceList);
  ProvinceList.fromJson(List data) {
    provinceList = [];
    for(var i = 0;i < 34;i ++){
      provinceList.add(Province.fromJson(data[i]));
    }
  }
}

class CountryList{
  List<Country> countryList;
  CountryList(this.countryList);
  CountryList.fromJson(List data) {
    countryList = [];
    for(var i = 34;i < data.length;i ++){
      countryList.add(Country.fromJson(data[i]));
    }
  }
}

class Country{
  String continents; //所属洲
  String provinceName;
  int currentConfirmedCount; //现存确诊
  int confirmedCount; //累计确诊
  int suspectedCount; //疑似病例
  int deadCount; //死亡人数
  int curedCount; //治愈人数

  Country({
    this.continents,
    this.provinceName,
    this.currentConfirmedCount,
    this.confirmedCount,
    this.suspectedCount,
    this.deadCount,
    this.curedCount,
  });

  factory Country.fromJson(Map data){
    return Country(
      continents: data['continents'],
      provinceName: data['provinceName'],
      currentConfirmedCount: data['currentConfirmedCount'],
      confirmedCount: data['confirmedCount'],
      suspectedCount: data['suspectedCount'],
      deadCount: data['deadCount'],
      curedCount: data['curedCount'],
    );
  }
}

class Province{
  String provinceName; //省名
  String provinceShortName; //省名简称
  int currentConfirmedCount; //现存确诊
  int confirmedCount; //累计确诊
  int suspectedCount; //疑似病例
  int deadCount; //死亡人数
  int curedCount; //治愈人数
  List<CityItem> cities;
  bool isExpanded = false;

  Province({
    this.provinceName,
    this.provinceShortName,
    this.currentConfirmedCount,
    this.confirmedCount,
    this.suspectedCount,
    this.deadCount,
    this.curedCount,
    this.cities,
    this.isExpanded,
  });

  factory Province.fromJson(Map data){
    return Province(
      provinceName: data['provinceName'],
      provinceShortName: data['provinceShortName'],
      currentConfirmedCount: data['currentConfirmedCount'],
      confirmedCount: data['confirmedCount'],
      suspectedCount: data['suspectedCount'],
      deadCount: data['deadCount'],
      curedCount: data['curedCount'],
      cities: data['cities'] != null ? CityList.fromJson(data['cities']).cityList : [],
      isExpanded: false,
    );
  }
}

class CityList{
  List<CityItem> cityList;
  CityList(this.cityList);
  CityList.fromJson(List data) {
    cityList = [];
    for(var i = 0;i < data.length;i ++){
      cityList.add(CityItem.fromJson(data[i]));
    }
  }
}

class CityItem {
  String cityName; //城市名
  int currentConfirmedCount; //现存确诊
  int confirmedCount; //累计确诊
  int suspectedCount; //疑似病例
  int deadCount; //死亡人数
  int curedCount; //治愈人数

  CityItem({
    this.cityName,
    this.currentConfirmedCount,
    this.confirmedCount,
    this.suspectedCount,
    this.deadCount,
    this.curedCount,
  });

  factory CityItem.fromJson(Map data){
    return CityItem(
      cityName: data['cityName'],
      currentConfirmedCount: data['currentConfirmedCount'],
      confirmedCount: data['confirmedCount'],
      suspectedCount: data['suspectedCount'],
      deadCount: data['deadCount'],
      curedCount: data['curedCount'],
    );
  }
}