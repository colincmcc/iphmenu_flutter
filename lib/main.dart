import 'package:flutter/material.dart';
import 'features/homepage/HomePageLiquor.dart';
import 'package:iphmenu/Routes.dart';

class MenuApp extends StatefulWidget {
  const MenuApp({Key key}) : super(key: key);

  @override
  MenuAppState createState() => new MenuAppState();
}

class MenuAppState extends State<MenuApp> {
  Widget home = new HomePageLiquor();

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "IPH Menu",
      home: home,
    );
  }
}

void main(){
  Routes.initRoutes();
  runApp(new MenuApp());
}
