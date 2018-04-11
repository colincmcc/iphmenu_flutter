import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/features/liquor/LiquorSummary.dart';
import 'package:iphmenu/features/common/objects.dart';

class LiquorDetailBody extends StatelessWidget {
  final LiquorItem liquoritem;

  LiquorDetailBody(this.liquoritem);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Theme.Colors.liquorDetailGradientEnd,
        child: new Stack (
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          new Container(
            color: Theme.Colors.liquorPageBackground,
            child: new Center(
              child: new Hero(
                tag: 'liquor-icon-${liquoritem.id}',
                child: new Stack (
                    children: <Widget>[
                    _getBackground(),
                _getGradient(),
                _getContent(),
                ]
                ),
              ),
            ),
          ),
        ]
    );
  }
  */
  Container _getBackground(){
    return new Container(
      child: new Image.network(liquoritem.image,
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient(){
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            Theme.Colors.liquorDetailGradientStart,
            Theme.Colors.liquorDetailGradientEnd
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }
  Container _getContent() {
    final _overviewTitle = "ABOUT".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new LiquorSummary(liquoritem,
            horizontal: false
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                  style: Theme.TextStyles.liquorDetailHeading,),
                new Separator(),
                new Text(
                    liquoritem.description, style: Theme.TextStyles.liquorDetail),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new BackButton(color: Colors.white),
    );
  }

}