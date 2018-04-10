import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorListBody.dart';
import 'package:iphmenu/features/common/gradientappbar.dart';
import 'package:iphmenu/Theme.dart' as Theme;

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar("IPH EXECUTIVE"), preferredSize: const Size.fromHeight(48.0)),
      body: new Container(
        child:  new HomePageTabbed(),

      ),
    );
  }
}

class HomePageTabbed extends StatefulWidget{
  _HomePageTabbedState createState() => new _HomePageTabbedState();

}

class _HomePageTabbedState extends State<HomePageTabbed> with SingleTickerProviderStateMixin{

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
            new LiquorListBody(),
            new Column(),
            new Column(),
          ]
      ),
    );
  }
}
/*
class HomePageTabbed extends StatefulWidget{
  HomePageTabbed createState() => new _HomePageTabbedState();
}
class _HomePageTabbedState extends State<HomePageTabbed> with SingleTickerProviderStateMixin{
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
  }
}
*/