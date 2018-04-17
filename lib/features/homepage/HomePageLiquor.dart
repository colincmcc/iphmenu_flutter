import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/modal/MenuModal.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/liquor/LiquorListPage.dart';



class HomePageLiquor extends StatefulWidget {
  const HomePageLiquor({Key key}): super(key: key);

  @override
  HomePageLiquorState createState() => new HomePageLiquorState();

}

class HomePageLiquorState extends State<HomePageLiquor>{
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  List<Widget> _menuListItems() {
    final List<Widget> listItems = <Widget>[];
    for (LiquorType liquorType in kAllLiquorTypeItems) {
      listItems.add(liquorType);
    }
    return listItems;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new Scaffold(
      backgroundColor: Theme.Colors.appBarGradientStart,
      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          new AnimatedAppBar(context, "IPH EXECUTIVE"),
          _getHomeContent()
        ]
      ),
    );

    return home;
  }
  _getHomeContent() {
    return new Container(
        child: new SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
                  (context, index) => new HomePageItem(kAllLiquorTypeItems[index]),
              childCount: kAllLiquorTypeItems.length,
            ),
          ),
        )
    );
  }

}


class HomePageItem extends StatelessWidget {
  final LiquorType liquorType;

  HomePageItem(this.liquorType);


  @override
  Widget build(BuildContext context) {

    final homeThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 8.0
      ),
      alignment:  FractionalOffset.centerLeft,
      child: new Hero(
        tag: "liquor-hero-${liquorType.title}",
        child: new Image.network(
          liquorType.imgLink,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );



    final homeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB( 76.0 , 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(liquorType.title, style: Theme.TextStyles.liquorTitle),
        ],
      ),
    );


    final homeContent = new Container(
      child: homeCardContent,
      height:  75.0 ,
      margin:
           new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.appBarGradientEnd,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
        onTap:
            () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new LiquorList(liquorType.title),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: new Stack(
            children: <Widget>[
              homeThumbnail,
              homeContent
            ],
          ),
        )
    );
  }

}