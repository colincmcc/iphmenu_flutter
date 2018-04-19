import 'package:flutter/material.dart';
import 'modal/LiquorItem.dart';
import 'features/homepage/HomePageLiquor.dart';
import 'package:iphmenu/Routes.dart';
import 'modal/MenuModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class MenuApp extends StatefulWidget {
  const MenuApp({Key key}) : super(key: key);

  @override
  MenuAppState createState() => new MenuAppState();
}

class MenuAppState extends State<MenuApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _liquorList;
  Future<bool> isAdmin;
  Widget home = new HomePageLiquor();

  void initState() {
    super.initState();
    _updatePrefs();
    print("main init");
  }
  _updatePrefs() async {
    final SharedPreferences prefs = await _prefs;
    final String liquorList = json.encode(liquoritems);

    setState(() {
      _liquorList = prefs.setString("masterLiquorList", liquorList).then((bool success) {
        return liquorList;
      });
    });
  }

  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> _kRoutes = <String, WidgetBuilder>{};
    for (LiquorType item in kAllLiquorTypeItems) {
      // For a different example of how to set up an application routing table
      // using named routes, consider the example in the Navigator class documentation:
      // https://docs.flutter.io/flutter/widgets/Navigator-class.html
      _kRoutes[item.routeName] = (BuildContext context) {
        return item.buildRoute(context);
      };
    }


    return new MaterialApp(
      title: "IPH Menu",
      routes: _kRoutes,
      home: home,
    );

  }

}

void main(){
  Routes.initRoutes();
  runApp(new MenuApp());
}
