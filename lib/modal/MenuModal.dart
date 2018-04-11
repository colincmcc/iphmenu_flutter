import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/liquor/LiquorListPage.dart';

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
    new LiquorType("Bourbon", "assets/img/lightbulb_solo.png", "Bourbon", "/bourbon", (BuildContext) => new LiquorListBody("Bourbon")),
    new LiquorType("Imported Whiskey", "assets/img/lightbulb_solo.png", "Imported", "/imported", (BuildContext) => new LiquorListBody("Imported Whisky")),
    new LiquorType("Tequila", "assets/img/lightbulb_solo.png", "Tequila", "/tequila", (BuildContext) => new LiquorListBody("Tequila")),
    new LiquorType("Rum", "assets/img/lightbulb_solo.png", "Rum", "/rum", (BuildContext) => new LiquorListBody("Rum")),
    new LiquorType("Beer", "assets/img/lightbulb_solo.png", "Beer", "/beer", (BuildContext) => new LiquorListBody("Beer")),
    new LiquorType("Cocktails", "assets/img/lightbulb_solo.png", "Cocktails", "/cocktails", (BuildContext) => new LiquorListBody("Cocktails")),
  ];
  return liquorTypeItems;
}

final List<LiquorType> kAllLiquorTypeItems = _buildLiquorTypeItems();