import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/HomePageBody.dart';
import 'package:iphmenu/modal/MenuModal.dart';

class MenuList extends StatelessWidget{

  final List<MenuModal> _menuModal;

  MenuList(this._menuModal);

  Widget build(BuildContext context){
    return new Scaffold(
      body: new Container(
        child: new ListView(
          children: _buildMenuList(),
        ),
      ),
    );
  }

  List<MenuListItem> _buildMenuList(){
    return _menuModal
        .map((menuItem) => new MenuListItem(menuItem))
        .toList();
  }

}

class MenuListItem extends StatelessWidget {

  final MenuModal _menuModal;

  MenuListItem(this._menuModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: new CircleAvatar(child: new Image.asset(_menuModal.imgLink)),
        title: new Text(_menuModal.menuName),
        onTap:(){
          Widget build(BuildContext context) {
            return new Container(
              child: new HomePageBody(),
            );
          }
        }
    );
  }
}