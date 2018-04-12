import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorSummary.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiquorList extends StatefulWidget{
  const LiquorList(this.liquorType, {Key key}): super(key: key);
  final String liquorType;

  @override
   LiquorListState createState() => new LiquorListState();
}

class LiquorListState extends State<LiquorList>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> liquorList;
  

  @override
  void initState() {
    super.initState();
    liquorList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('masterLiquorList'));
    });
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new PreferredSize(child: new GradientAppBar(widget.liquorType), preferredSize: const Size.fromHeight(48.0)),
        body: new Column(
          children: <Widget>[
            //_getLiquorContent(widget.liquorType),
            new FutureBuilder<String>(
              future: liquorList,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return new Container(
                        child: _getStoredLiquorContent(snapshot.data),
                      );
                }
              }
          )
          ],
        ),
      );
      

  }

  _getStoredLiquorContent(jsonData){
    var data = json.decode(jsonData);
    final storedLiquorItems = (data as List).map((i) => new LiquorItem.fromJson(i));

    List<LiquorItem> storedLiquorByType = storedLiquorItems.where((LiquorItem liquoritem) => liquoritem.type.contains(widget.liquorType)).toList();

    return new Expanded(
      child: new Container(
        color: Theme.Colors.appBarGradientStart,
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new LiquorSummary(storedLiquorByType[index]),
                  childCount: storedLiquorByType.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _getLiquorContent(liquorType){
    List<LiquorItem> liquorByType = liquoritems.where((LiquorItem liquoritem) => liquoritem.type.contains(liquorType)).toList();

    return new Expanded(
      child: new Container(
        color: Theme.Colors.appBarGradientStart,
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new LiquorSummary(liquorByType[index]),
                  childCount: liquorByType.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}