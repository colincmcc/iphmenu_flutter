import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;

class LiquorDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top
      ),
      child: new Row(
        children: <Widget>[
          new BackButton(
              color: Theme.Colors.liquorTitle
          ),
        ],
      ),
    );
  }
}