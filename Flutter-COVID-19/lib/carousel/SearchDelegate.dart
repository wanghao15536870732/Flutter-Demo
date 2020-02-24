import 'package:flutter/material.dart';
import 'package:flutter_app/provinces/country.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  final List<Province> provinceList;
  static List<String> recentSuggest = [];
  static List<String> searchList = [];

  SearchBarDelegate(this.provinceList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  //显示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query,style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    recentSuggest.clear();
    searchList.clear();
    for(int i = 0;i < provinceList.length;i ++){
      recentSuggest.add(provinceList[i].provinceName);
      searchList.add(provinceList[i].provinceName);
    }

    final suggestionList = query.isEmpty
      ? recentSuggest
      : searchList.where((input)=> input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length ,
      itemBuilder: (context,index)=>ListTile(
        title: RichText(text: TextSpan(text: suggestionList[index].substring(0,query.length),
          style:TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: suggestionList[index].substring(query.length),
              style: TextStyle(color: Colors.grey)
            )
          ]
        )),
        onTap: (){
          query = searchList[index].toString();
          showResults(context);
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }
}