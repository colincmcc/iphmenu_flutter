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
  Future<String> _liquorList;

  @override
  void initState() {
    super.initState();
    _liquorList = _prefs.then((SharedPreferences prefs) {
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
              future: _liquorList,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      _getStoredLiquorContent('${snapshot.data}');
                }
              }
          )
          ],
        ),
      );


  }

  _getStoredLiquorContent(jsonData){
    //Future<String> liquorItems = new Future();
    //List<LiquorItem> listLiquorItems = jsonDecode(_liquorList);
    // List<LiquorItem> liquorByType = listLiquorItems.where((LiquorItem liquoritem) => liquoritem.type.contains(liquorType)).toList();

    List<LiquorItem> storedLiquorItems = json.decode(jsonData);
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







/////////////////////////////////////////////////////////////





class LiquorListBody extends StatelessWidget {
  const LiquorListBody(this.liquorType);
  final String liquorType;




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar(liquorType), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[

          _getLiquorContent(liquorType)
        ],
      ),
    );

  }


  _getStoredLiquorContent(liquorType){

    List<LiquorItem> liquorByType = listLiquorItems.where((LiquorItem liquoritem) => liquoritem.type.contains(liquorType)).toList();
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


  Container _getToolbar(BuildContext context, liquorType) {
    return new Container(
        margin: new EdgeInsets.only(
            top: MediaQuery
                .of(context)
                .padding
                .top),
        child: new Row(
          children: <Widget>[
            new BackButton(color: Theme.Colors.liquorTitle),
            new Text(liquorType, style: Theme.TextStyles.liquorTitle)
          ],
        )
    );
  }
}
