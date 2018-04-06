import 'package:flutter/material.dart';
import 'package:iphmenu/features/common/LiquorSummary.dart';
import 'package:iphmenu/models/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;

class HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: Theme.Colors.liquorPageBackground,
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

  }
}