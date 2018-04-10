import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/LiquorList.dart';
import 'package:iphmenu/features/common/gradientappbar.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/MenuList.dart';
import 'package:iphmenu/modal/MenuModal.dart';
import 'package:flutter/foundation.dart';

class _AppBarBackground extends StatelessWidget{

}

class HomePageLiquor extends StatefulWidget {
  const HomePageLiquor({Key key}): super(key: key);

  @override
  HomePageLiquorState createState() => new HomePageLiquorState();

}

class HomePageLiquorState extends State<HomePageLiquor>{
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




  Widget build(BuildContext context) {
    Widget home = new Scaffold(
      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: const Text("IPH Executive"),
              background: const _AppBarBackground(),
            ),
          )
        ]
      ),
    );


    return home;
  }

}
/*
class HomePageBody extends StatefulWidget{
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();

}

class _HomePageBodyState extends State<HomePageBody> {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new MenuList(_buildMenuList()),
      ),
    );
  }
}
*/