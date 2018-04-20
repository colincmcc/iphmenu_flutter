import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:iphmenu/features/homepage/HomePageLiquor.dart';
import 'package:iphmenu/features/liquor/LiquorListPage.dart';
import 'package:iphmenu/features/liquorDetail/LiquorDetail.dart';
import 'package:iphmenu/features/admin/LoginPage.dart';
import 'package:iphmenu/features/admin/AddLiquorForm.dart';
import 'package:iphmenu/features/admin/AddCategoryForm.dart';
import 'package:iphmenu/Theme.dart' as Theme;

var rootHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePageLiquor();
});

var liquorHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String type = params["type"]?.first;
  return new LiquorList(type);
});

var liquorDetailHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return new LiquorDetail(id);
});

var loginHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String admin = params["setup"]?.first;
  String setup = params["admin"]?.first;
  String result = params["result"]?.first;
  return new LoginPage(setup, admin);
});


var addLiquorHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LiquorFormField();
});


var menuFunctionHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String result = params["result"]?.first;
      showDialog(
        context: context,
        child: new AlertDialog(
          content: new Text("$result"),
          actions: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text("OK"),
              ),
            ),
          ],
        ),
      );
    });

