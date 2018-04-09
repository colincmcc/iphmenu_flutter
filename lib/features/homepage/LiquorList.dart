import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/LiquorRow.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/features/common/LiquorSummary.dart';

class LiquorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Container(

        color: Theme.Colors.liquorPageBackground,
        child: new ListView.builder(
          itemExtent: 160.0,
          itemCount: liquoritems.length,
          itemBuilder: (_, index) => new LiquorSummary(liquoritems[index]),
        ),

      ),

    );
  }

}