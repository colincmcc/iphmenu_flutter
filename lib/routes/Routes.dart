import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {

  static String root = "/";
  static String liquorPage = "/liquor";
  static String liquorDetail = "/liquor/detail";
  static String login = "/admin/login";
  static String addLiquor = "/admin/addLiquor";
  static String function = "/function";


  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(liquorPage, handler: liquorHandler);
    router.define(liquorDetail, handler: liquorDetailHandler);
    router.define(login, handler: loginHandler);
    router.define(addLiquor, handler: addLiquorHandler);
    router.define(function, handler: menuFunctionHandler);

  }

}