import 'package:flutter/material.dart';
import 'package:iphmenu/features/common/LiquorSummary.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;

class LiquorListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
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
        )
      ],
    );
  }

  Column _liquorContent = new Column(
    children: <Widget>[
      new Expanded(
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
      )
    ],
  );
}
