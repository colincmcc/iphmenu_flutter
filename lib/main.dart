import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:iphmenu/routes/Routes.dart';
import 'package:iphmenu/routes/application.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'features/homepage/HomePageLiquor.dart';


class MenuApp extends StatefulWidget{
  const MenuApp({Key key}): super(key: key);

  @override
  MenuAppState createState() => new MenuAppState();
}

class MenuAppState extends State<MenuApp>{

  MenuAppState(){
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      title: 'IPH Executive',
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}


void main(){
  runApp(new MenuApp());
}
