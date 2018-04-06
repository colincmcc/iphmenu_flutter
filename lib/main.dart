import 'package:flutter/material.dart';
import 'features/homepage/Home.dart';
import 'package:iphmenu/Routes.dart';

class MenuApp extends StatefulWidget {
  @override
  MenuAppState createState() => new MenuAppState();
}

class MenuAppState extends State<MenuApp> {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "IPH Menu",
      home: new HomePage(),
    );
  }
}

void main(){
  Routes.initRoutes();
  runApp(new MenuApp());
}
