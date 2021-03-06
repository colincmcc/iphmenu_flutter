import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorSummary.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/AppBars.dart';

class LiquorListBody extends StatelessWidget {

  LiquorListBody(this.liquorType);

  final String liquorType;

  getLiquorByType(){
    List<LiquorItem> liquorByType = liquoritems.where((LiquorItem liquoritem) => liquoritem.type.contains(liquorType)).toList();
    return liquorByType;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new AnimatedAppBar(context, liquorType), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[
          _getLiquorContent(liquorType)
        ],
      ),
    );
  }

  _getLiquorContent(liquorType) {
    List<LiquorItem> liquorByType = liquoritems.where((LiquorItem liquoritem) => liquoritem.type.contains(liquorType)).toList();
    return new Expanded(
      child: new Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.appBarGradientStart,
                  Theme.Colors.appBarGradientEnd,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new LiquorSummary(liquorByType[index]),
                  childCount: liquoritems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container _getToolbar(BuildContext context, liquorType) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new Row(
        children: <Widget>[
          new BackButton(color: Theme.Colors.liquorTitle),
          new Text(liquorType, style: Theme.TextStyles.liquorTitle)
        ],
      )
    );
  }
}
