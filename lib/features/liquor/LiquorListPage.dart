import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorSummary.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiquorList extends StatefulWidget{
  const LiquorList(this.type, {Key key}): super(key: key);

  final String type;

  @override
  LiquorListState createState() => new LiquorListState();

}
class LiquorListState extends State<LiquorList> {


  String liquorJson;
  List<LiquorItem> liquorList;
  bool isAdmin = false;
  int _isLoading = 1;
  var liquorscreen;

  void getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = prefs.getBool("isAdmin") ?? false;
    });
    liquorJson = prefs.getString(widget.type);
    
    if(liquorJson == null) {
      setState(() {
        _isLoading = 3;
      });
      print("liquorjson is null, load 3");

    }
    
    var data = json.decode(liquorJson);
    print("data is $data");
    liquorList = (data as List).map((i) => new LiquorItem.fromJson(i)).toList();
    
    if(liquorList != null) {
      setState(() {
        _isLoading = 2;
      });
      print("liquorlist is not null, load 2");
    }
  }

  @override
  void initState() {
    print(widget.type);
    super.initState();
    getSharedPrefs();
    print("$isAdmin is admin");
  }

  @override
  Widget build(BuildContext context) {
    switch (_isLoading) {
      case 1:
        return new CircularProgressIndicator();
      case 2:
        return _liquorPageContent();
      case 3:
        return new Center(
          child: new Text("Please add more!"),
        );
    }
  }

  _liquorPageContent() {
    void dismissLiquor(index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        liquorList.removeAt(index);
        liquorJson = json.encode(liquorList);
        prefs.setString(widget.type, liquorJson).then((bool success) {
          print("success");
        });
      });
    }

    return new Scaffold(
      backgroundColor: Theme.Colors.appBarGradientStart,
      appBar: new PreferredSize(child: new GradientAppBar(widget.type.toUpperCase()), preferredSize: const Size.fromHeight(48.0)),
      body: new Container(
        child: new ListView.builder(
          itemCount: liquorList.length,
              itemBuilder: (context, index) {
                if(isAdmin){
                  return new Dismissible(
                      key: new ObjectKey(LiquorSummary(liquorList[index])),
                      child: new LiquorSummary(liquorList[index]),
                      onDismissed: (DismissDirection direction) {
                        dismissLiquor(index);
                        },
                );
                } else {
                  return new LiquorSummary(liquorList[index]);
                }
              }
          )
      ),
    );


  }
}
