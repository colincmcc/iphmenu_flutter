import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:fluro/fluro.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/routes/application.dart';
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:iphmenu/Theme.dart' as Theme;



class HomePageLiquor extends StatefulWidget {
  const HomePageLiquor({Key key}): super(key: key);

  @override
  HomePageLiquorState createState() => new HomePageLiquorState();

}

class HomePageLiquorState extends State<HomePageLiquor>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  List<String> _liquorTypes = [];
    int _isLoading = 1;
    List<Widget> menuWidgets;

    Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 3), () { completer.complete(null); });
    return completer.future.then((_) {
      _getLiquorTypes();
      _scaffoldKey.currentState?.showSnackBar(new SnackBar(
          content: const Text('Liquor Updated!'),
          action: new SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              }
          )
      ));
    });
  }
  _getLiquorTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _liquorTypes = prefs.getStringList("liquorTypes");
      print(_liquorTypes);
      if(_liquorTypes != null) {
        menuWidgets = _liquorTypes.map((String _liquor) =>
            menuButton(context, _liquor.toUpperCase(), _liquor)
        ).toList();
        _isLoading = 2;
        print("isloading 2");
      }
      else {
        _isLoading = 3;
        print("isloading 3");
      }
      print(menuWidgets);

    });
  }
  @override
  void initState() {
    super.initState();
    _getLiquorTypes();

  }

  @override
  Widget build(BuildContext context) {

    _getHomeContent(){
      switch (_isLoading) {
        case 1:
          return new SliverToBoxAdapter(
              child: new Center(
                  child: new CircularProgressIndicator()
              )
          );
        case 2:
          return new Container(
              child: new SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  sliver: new SliverToBoxAdapter(
                    child: new Column(
                      children: menuWidgets,
                    ),
                  )
              )
          );
        case 3:
          return new SliverToBoxAdapter(
            child: new Center(
              child: new Text("Please add menu items with the Add Liquor page!"),
            ),
          );
      }
    }
    Widget home = new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.Colors.appBarGradientStart,
        body: new RefreshIndicator(
          key: _refreshIndicatorKey,
            child: new CustomScrollView(
              slivers: <Widget>[
                new AnimatedAppBar(context, "IPH EXECUTIVE"),
                _getHomeContent()
              ],
            ),
            onRefresh: _handleRefresh)

    );
    /*
    Widget home = new Scaffold(
      key: _scaffoldKey,
        backgroundColor: Theme.Colors.appBarGradientStart,
        body: new CustomScrollView(
            slivers: <Widget>[
              new AnimatedAppBar(context, "IPH EXECUTIVE"),
              _getHomeContent()
            ],
        )
    ); */
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
    String type = "";
    String result;
    TransitionType transitionType = TransitionType.native;


    if (key != "function-call") {
      String route = "/liquor?type=$key";
      if (result != null) {
        route = "$route&result=$result";
      }
      Application.router.navigateTo(
          context, route,
          transition: transitionType).then((result) {
        if (key == "pop-result") {
          Application.router.navigateTo(context, "/function?result=$result");
        }
      });
    } else if (key == "notAdmin") {
      result = "Please login first!";
      Application.router.navigateTo(context, "/function?result=$result");
    }
  }


}