import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/LiquorListPage.dart';
class LiquorType extends StatelessWidget{

  final String title;
  final String imgLink;
  final String category;
  final String routeName;
  final WidgetBuilder buildRoute;

  const LiquorType (this.title, this.imgLink, this.category, this.routeName, this.buildRoute);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(title),
      onTap: (){
        if( routeName != null) {
          Timeline.instantSync('Start Transition', arguments: <String, String>{
            'from': '/',
            'to': routeName
          });
          Navigator.pushNamed(context, routeName);
        }
      },
    );
  }
}

List<LiquorType> _buildLiquorTypeItems () {

  final List<LiquorType> liquorTypeItems = <LiquorType>
  [
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "bourbon", "/bourbon", (BuildContext) => new LiquorListBody()),
  ];
  return liquorTypeItems;
}

final List<LiquorType> kAllLiquorTypeItems = _buildLiquorTypeItems();