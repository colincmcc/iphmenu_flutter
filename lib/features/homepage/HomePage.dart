import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/LiquorList.dart';
import 'package:iphmenu/features/homepage/gradientappbar.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/HomePageBody.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new PreferredSize(child: new GradientAppBar("IPH Executive List"), preferredSize: const Size.fromHeight(48.0)),
          body: new HomePageBody(),
          ),
      ),
    );
  }
}
/*
class HomePageBody extends StatefulWidget {

  _HomePageBodyState createState() => new _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Theme.Colors.liquorPageBackground,
      appBar: new TabBar(
        controller: _tabController,
        tabs: [
          new Tab(icon: new Icon(Icons.directions_car)),
          new Tab(icon: new Icon(Icons.directions_transit)),
          new Tab(icon: new Icon(Icons.directions_bike)),
        ],
      ),
      body: new TabBarView(
          controller: _tabController,
          children: [

            new LiquorList(),
            new Container(),
            new Container(),
          ]
      ),
    );
    */
/*
    return new Column(
      children: <Widget>[
        new LiquorList(),
      ],
    );

*/