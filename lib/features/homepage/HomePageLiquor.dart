import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:fluro/fluro.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/routes/application.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var menuWidgets = <Widget>[
      new AnimatedAppBar(context, "IPH EXECUTIVE"),
      menuButton(context, "Bourbon", "bourbon"),
      menuButton(context, "Imported Whiskey", "imported"),
      menuButton(context, "Tequila", "tequila"),
      menuButton(context, "Rum", "rum"),
      menuButton(context, "Spirits", "spirits"),
      menuButton(context, "Beer", "beer"),
      menuButton(context, "Cocktails", "cocktails"),
    ];
    Widget home = new Scaffold(
        backgroundColor: Theme.Colors.appBarGradientStart,
        key: _scaffoldKey,
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuWidgets
        )
    );

    return home;
  }


  // helpers
  Widget menuButton(BuildContext context, String title, String key) {


    // HERO IMAGE  - NOT USED YET
    // todo Hero image for main menu button
    /*
    final homeThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 8.0
      ),
      alignment:  FractionalOffset.centerLeft,
      child: new Hero(
        tag: "liquor-hero-${liquorType.title}",
        child: new Image.network(
          imgLink,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );
    */

    // MENU CONTENT
    final homeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB( 16.0 , 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(title, style: Theme.TextStyles.liquorTitle),
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



    return new Padding(
      padding: new EdgeInsets.all(4.0),
      child: new ConstrainedBox(
        constraints: new BoxConstraints(minHeight: 42.0),
        child: new FlatButton(
          highlightColor: const Color(0x11FFFFFF),
          splashColor: const Color(0x22FFFFFF),
          child: homeContent,
          onPressed: () {
            tappedMenuButton(context, key);
          },
        ),
      ),
    );
  }

  // actions
  void tappedMenuButton(BuildContext context, String key) {
    String message = "";
    String hexCode = "#FFFFFF";
    String result;
    TransitionType transitionType = TransitionType.native;
    if (key != "custom" && key != "function-call") {
      if (key == "bourbon") {
        hexCode = "#F76F00";
        message = "This screen should have appeared using the default flutter animation for the current OS";
      } else if (key == "preset-from-left") {
        hexCode = "#5BF700";
        message = "This screen should have appeared with a slide in from left transition";
        transitionType = TransitionType.inFromLeft;
      } else if (key == "preset-fade") {
        hexCode = "#F700D2";
        message = "This screen should have appeared with a fade in transition";
        transitionType = TransitionType.fadeIn;
      } else if (key == "pop-result") {
        transitionType = TransitionType.native;
        hexCode = "#7d41f4";
        message = "When you close this screen you should see the current day of the week";
        result = "Today is ${_daysOfWeek[new DateTime.now().weekday]}!";
      }

      String route = "/demo?message=$message&color_hex=$hexCode";

      if (result != null) {
        route = "$route&result=$result";
      }

      Application.router.navigateTo(
          context, route,
          transition: transitionType).then((result) {
        if (key == "pop-result") {
          Application.router.navigateTo(context, "/liquor/func?message=$result");
        }
      });
    } else if (key == "custom") {
      hexCode = "#DFF700";
      message = "This screen should have appeared with a crazy custom transition";
      var transition =
          (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return new ScaleTransition(
          scale: animation,
          child: new RotationTransition(
            turns: animation,
            child: child,
          ),
        );
      };
      Application.router.navigateTo(
        context,
        "/demo?message=$message&color_hex=$hexCode",
        transition: TransitionType.custom,
        transitionBuilder: transition,
        transitionDuration: const Duration(milliseconds: 600),
      );
    } else {
      message = "You tapped the function button!";
      Application.router.navigateTo(context, "/demo/func?message=$message");
    }
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
      margin: new EdgeInsets.fromLTRB( 16.0 , 16.0, 16.0, 16.0),
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