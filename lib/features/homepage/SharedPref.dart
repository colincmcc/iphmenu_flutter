// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/modal/LiquorItem.dart';

class SharedPref extends StatefulWidget {
  SharedPref({Key key}) : super(key: key);

  @override
  SharedPrefState createState() => new SharedPrefState();
}

class SharedPrefState extends State<SharedPref> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _liquorList;

  Future<Null> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final String liquorList = json.encode(liquoritems);

    setState(() {
      _liquorList = prefs.setString("masterLiquorList", liquorList).then((bool success) {
        return liquorList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _liquorList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('masterLiquorList'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: new Center(
          child: new FutureBuilder<String>(
              future: _liquorList,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return new Text(
                        ' ${snapshot.data}',
                      );
                }
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}