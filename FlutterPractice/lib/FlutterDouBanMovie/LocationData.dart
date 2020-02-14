
class LocationData{
  String address;
  String province;
  String city;
  String latitude;
  String longitude;
  String district;

  LocationData({
    this.address,
    this.province,
    this.city,
    this.latitude,
    this.longitude,
    this.district,
  });

  factory LocationData.fromJson(Map<String,dynamic> json){
    return frommap(json);
  }

  static LocationData frommap(Map map){
    String add = map['address'];
    String pro = map['province'];
    String city = map['city'];
    String lat =  map['latitude'];
    String lon =  map['longitude'];
    String dis =  map['district'];

    print(add);
    print(pro);
    print(city);
    print(lat);
    print(lon);
    print(dis);

    return new LocationData(
      address: add,
      province: pro,
      city: city,
      latitude: lat,
      longitude: lon,
      district: dis,
    );
  }

  factory LocationData.empty(){
    return LocationData(
      address: '',
      province: '',
      city: '',
      latitude: '',
      longitude: '',
      district: '',
    );
  }

}