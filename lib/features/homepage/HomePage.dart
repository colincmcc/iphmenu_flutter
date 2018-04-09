import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/LiquorList.dart';
import 'package:iphmenu/features/homepage/gradientappbar.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/MenuList.dart';
import 'package:iphmenu/modal/MenuModal.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar("IPH EXECUTIVE"), preferredSize: const Size.fromHeight(48.0)),
      body: new Container(
        child:  new HomePageBody(),

      ),
    );
  }
}

class HomePageBody extends StatefulWidget{
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();

}

class _HomePageBodyState extends State<HomePageBody> {
  _buildMenuList(){
    return <MenuModal>[
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
      const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),

    ];
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new MenuList(_buildMenuList()),
      ),
    );
  }
}