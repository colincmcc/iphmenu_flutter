import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'features/liquorDetail/LiquorDetail.dart';
import 'features/liquor/LiquorListBody.dart';


class Routes {
  static final Router _router = new Router();


  static var liquorDetailHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new LiquorDetail(params["id"][0]);
      });
  static var liquorPageHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new LiquorListBody();
      });

  static void initRoutes() {
    _router.define("/detail/:id", handler: liquorDetailHandler);
    _router.define("/bourbon", handler: liquorPageHandler);

  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }

}