import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquorDetail/LiquorDetailAppbar.dart';
import 'package:iphmenu/features/liquorDetail/LiquorDetailBody.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/modal/Liquors.dart';

class LiquorDetail extends StatelessWidget {

  final LiquorItem liquoritem;

  LiquorDetail(String id) :
        liquoritem = LiquorDao.getLiquorById(id);



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new LiquorDetailBody(liquoritem),
          new LiquorDetailAppBar(),
        ],
      ),
    );
  }
}