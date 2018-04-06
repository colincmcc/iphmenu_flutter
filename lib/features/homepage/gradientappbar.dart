import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;



  GradientAppBar(this.title);

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
        children: <Widget>[
        new Text(
          title,
          style: const TextStyle(
            color: Theme.Colors.appBarTitle,
            fontFamily: 'Typewriter',
            fontWeight: FontWeight.w800,
            fontSize: 36.0
          )
        ),
          new Container(width: 20.0),
          new Image(
            image: new AssetImage("assets/img/lightbulb_solo.png"),
            height: 30.0,
            width:30.0,
          ),
        ]
      ),
    );
  }
}