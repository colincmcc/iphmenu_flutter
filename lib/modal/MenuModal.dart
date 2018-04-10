import 'package:flutter/material.dart';

class MenuModal{
  final String menuName;
  final String imgLink;
  final Color menuColor;

  const MenuModal (this.menuName, this.imgLink, this.menuColor);

}

List<MenuListItems> menuListItems = [
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
    const MenuModal("Bourbon", "assets/img/lightbulb_solo.png", Theme.Colors.liquorCard),
]