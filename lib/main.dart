import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/SharedPref.dart';
import 'features/homepage/HomePageLiquor.dart';
import 'package:iphmenu/Routes.dart';
import 'modal/MenuModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MenuApp extends StatefulWidget {
  const MenuApp({Key key}) : super(key: key);

  @override
  MenuAppState createState() => new MenuAppState();
}

class MenuAppState extends State<MenuApp> {
  Widget home = new HomePageLiquor();
  Widget shared = new SharedPref();
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
