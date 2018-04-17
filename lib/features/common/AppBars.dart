import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/features/admin/AddLiquorForm.dart';
import 'package:iphmenu/features/admin/LoginPage.dart';

final double _kFlexibleSpaceMaxHeight = 256.0;
final String _kSmallLogoImage = 'assets/img/lightbulb_solo.png';
final double _kAppBarHeight = 150.0;
final double _kFabHalfSize = 28.0; // TODO(mpcomplete): needs to adapt to screen size
final double _kLiquorPageMaxWidth = 500.0;

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;
  final bool hasStack;


  GradientAppBar(this.title, {this.hasStack =false});
  GradientAppBar.back(this.title) : this.hasStack = true;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight +barHeight,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Theme.Colors.appBarGradientStart,
            Theme.Colors.appBarGradientEnd,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        )
      ),

      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        new Container(
          child: new BackButton(
              color: Theme.Colors.liquorTitle
          )
        ),
        new Text(
          title,
          style: const TextStyle(
            color: Theme.Colors.appBarTitle,
            fontFamily: 'Typewriter',
            fontWeight: FontWeight.w600,
            fontSize: 36.0
          )
        ),
          new Image(
            image: new AssetImage("assets/img/lightbulb_solo.png"),
            height: 40.0,
            width:40.0,
          ),
        ]
      ),
    );
  }
}
enum AppbarAction {
  login,
  addliquor
}
class AnimatedAppBar extends StatefulWidget{
  AnimatedAppBar(this.context, this.pageTitle);
  final BuildContext context;
  final String pageTitle;

  AnimatedAppBarState createState() => new AnimatedAppBarState();
}


class AnimatedAppBarState extends State<AnimatedAppBar>{
  bool isSetup;
  bool isAdmin;
  String _loginStatus = "not set";



  void _addLiquor() {
    print("add liquor isadmin $isAdmin");
    if(isAdmin) {
        Navigator.of(widget.context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new LiquorFormField(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        );
      }
      else
        print("not admin");
  }


  void _loginPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      isAdmin = prefs.getBool("isAdmin");
      print(isAdmin);
      if(isAdmin) {
        print("logging out");
        prefs.setBool("isAdmin", false);
        isAdmin = prefs.getBool("isAdmin");
        _loginStatus = "Login";
        }

      else {
        Navigator.of(widget.context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new LoginPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        );
      }
    });
    print(isAdmin);

  }
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSetup = prefs.getBool("isSetup") ?? false;
    isAdmin = prefs.getBool("isAdmin")  ?? false;
    print(isSetup);
    print(isAdmin);
    setState(() {

      if(isSetup) {
        _loginStatus = "Login";
        print("login");
      }
      if(isAdmin) {
        _loginStatus = "Logout";
        print("logout");
      }
      if (isSetup = false) {
        _loginStatus = "Setup Pin";
        print("setup pin");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return new SliverAppBar(
      //backgroundColor: Theme.Colors.appBarGradientEnd,
      pinned: true,
      expandedHeight: _kAppBarHeight,
      actions: <Widget>[
        new PopupMenuButton<AppbarAction>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<AppbarAction>>[
              new PopupMenuItem<AppbarAction>(
                  value: AppbarAction.login,
                  child: new Text(_loginStatus)
              ),

              const PopupMenuItem<AppbarAction>(
                  value: AppbarAction.addliquor,
                  child: const Text('Add Liquor')
              ),
            ],
            onSelected: (AppbarAction action) {
              switch (action) {
                case AppbarAction.login:
                  _loginPage();
                  break;
                case AppbarAction.addliquor:
                  _addLiquor();
                  break;
              }
            }
        ),

      ],
      flexibleSpace: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);
          final double extraPadding = new Tween<double>(begin: 10.0, end: 24.0).lerp(t);
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.appBarGradientStart,
                        Theme.Colors.appBarGradientEnd,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp
                  )
              ),
            child: new Padding(
              padding: new EdgeInsets.only(
                top: statusBarHeight + 0.5 * extraPadding,
                bottom: extraPadding,
              ),
              child: new Center(
                  child: new PageLogo(height: logoHeight, t: t.clamp(0.0, 1.0), pageTitle: widget.pageTitle)
              ),
            )
          );

        },
      ),
    );
  }
}


class PageLogo extends StatefulWidget{
  const PageLogo({this.height, this.t, this.pageTitle});

  final double height;
  final double t;
  final String pageTitle;

  @override
  _PageLogoState createState() => new _PageLogoState();
}

class _PageLogoState extends State<PageLogo> {
  static const double kLogoHeight = 190.0;
  static const double kLogoWidth = 300.0;
  static const double kImageHeight = 120.0;
  static const double kTextHeight = 120.0;
  _PageLogoState();


  final RectTween _textRectTween = new RectTween(
      begin: new Rect.fromLTWH(0.0, kLogoHeight, kLogoWidth, kTextHeight),
      end: new Rect.fromLTWH(0.0, kImageHeight, kLogoWidth, kTextHeight)
  );
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);
  final RectTween _imageRectTween = new RectTween(
    begin: new Rect.fromLTWH(0.0, 0.0, kLogoWidth, kLogoHeight),
    end: new Rect.fromLTWH(0.0, 0.0, kLogoWidth, kImageHeight),
  );

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform: new Matrix4.identity()
        ..scale(widget.height / kLogoHeight),
      alignment: Alignment.topCenter,
      child: new SizedBox(
        width: kLogoWidth,
        child: new Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            new Positioned.fromRect(
              rect: _imageRectTween.lerp(widget.t),
              child: new Image.asset(
                _kSmallLogoImage,
                fit: BoxFit.contain,
              ),
            ),
            new Positioned.fromRect(
              rect: _textRectTween.lerp(widget.t),
              child: new Opacity(
                opacity: _textOpacity.transform(widget.t),
                child: new Text(
                    widget.pageTitle, style: Theme.TextStyles.liquorMenu,
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}