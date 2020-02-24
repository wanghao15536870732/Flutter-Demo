import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/overall/overall_home_widget.dart';
import 'package:flutter_app/provinces/country.dart';

class ExpansionPanelPage extends StatefulWidget {
  final List<Province> provinceList;
  final List<Country> countryList;

  const ExpansionPanelPage({Key key, this.provinceList, this.countryList}) : super(key: key);

  @override
  _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
}

class _ExpansionPanelPageState extends State<ExpansionPanelPage> {
  //标题item
  Widget _buildTitleItem(String title, Color color) {
    return Container(
        width: 75.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold)),
        ));
  }

  //市级item
  Widget _buildCityItem(String text) {
    return Container(
        width: 70.0,
        height: 25.0,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ));
  }

  //省级item
  Widget _buildProvinceItem(String text) {
    return Container(
        width: 55.0,
        height: 25.0,
        margin: EdgeInsets.only(left: 1.0, right: 1.0),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),

          ),
        ));
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTitleItem("地区", Colors.grey),
          _buildTitleItem("现存确诊", Colors.red[300]),
          _buildTitleItem("累计确诊", Colors.red[600]),
          _buildTitleItem("死亡", Colors.brown),
          _buildTitleItem("治愈", Colors.green),
        ],
      ),
    );
  }

  //市级行
  Widget _buildCityRow(CityItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCityItem(item.cityName),
          _buildCityItem(item.currentConfirmedCount > 0
              ? item.currentConfirmedCount.toString()
              : "无"),
          _buildCityItem(
              item.confirmedCount > 0 ? item.confirmedCount.toString() : "无"),
          _buildCityItem(item.deadCount > 0 ? item.deadCount.toString() : "无"),
          _buildCityItem(
              item.curedCount > 0 ? item.curedCount.toString() : "无"),
        ],
      ),
    );
  }

  //市级列表
  Widget _buildCities(List<CityItem> cities) {
    return Column(
      children: <Widget>[
        _buildTitle(),
        Container(
          color: Colors.grey[200],
          child: Column(
            children: cities
                .asMap()
                .map((i, v) => MapEntry(i, _buildCityRow(cities[i])))
                .values
                .toList(),
          ),
        )
      ],
    );
  }

  //省级行
  Widget _buildProvince(Province province) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildProvinceItem(province.provinceShortName),
        _buildProvinceItem(province.currentConfirmedCount.toString()),
        _buildProvinceItem(province.confirmedCount.toString()),
        _buildProvinceItem(province.deadCount.toString()),
        _buildProvinceItem(province.curedCount.toString()),
      ],
    );
  }

  //市级行
  Widget _buildCountryRow(Country country) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCityItem(country.provinceName),
          _buildCityItem(country.currentConfirmedCount > 0
              ? country.currentConfirmedCount.toString()
              : ""),
          _buildCityItem(
              country.confirmedCount > 0 ? country.confirmedCount.toString() : ""),
          _buildCityItem(country.deadCount > 0 ? country.deadCount.toString() : ""),
          _buildCityItem(
              country.curedCount > 0 ? country.curedCount.toString() : ""),
        ],
      ),
    );
  }

  Widget _buildCountry(List<Country> country){
    return Column(
      children: <Widget>[
        _buildTitle(),
        Container(
          color: Colors.grey[200],
          child: Column(
            children: country
                .asMap()
                .map((i, v) => MapEntry(i, _buildCountryRow(country[i])))
                .values
                .toList(),
          ),
        )
      ],
    );
  }

  Widget _buildPanel() {
    List<Province> _data = this.widget.provinceList;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Province province) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: _buildProvince(province),
            );
          },
          body: province.cities.length > 0
              ? _buildCities(province.cities)
              : Container(),
          isExpanded: province.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Card(child: titleWidget("疫情日报")),
            Container(margin: EdgeInsets.only(left: 5.0,right: 5.0),child: _buildPanel()),
            Card(child: titleWidget("全球数据")),
            Card(child: _buildCountry(this.widget.countryList))
          ],
        ),
      ),
    );
  }
}
