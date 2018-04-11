import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorSummary.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/AppBars.dart';

class LiquorListBody extends StatelessWidget {

  String liquorType = "Bourbon";
  final List<liquorItems>
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new AnimatedAppBar(context, "IPH EXECUTIVE"), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[
          _liquorContent
        ],
      ),
    );

  }

  Expanded _liquorContent =  new Expanded(
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
                        (context, index) => new LiquorSummary(liquoritems[index]),
                    childCount: liquoritems.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
