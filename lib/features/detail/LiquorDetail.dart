import 'package:flutter/material.dart';
import 'package:iphmenu/features/detail/LiquorDetailAppbar.dart';
import 'package:iphmenu/features/detail/LiquorDetailBody.dart';
import 'package:iphmenu/models/LiquorItem.dart';
import 'package:iphmenu/models/Liquors.dart';

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