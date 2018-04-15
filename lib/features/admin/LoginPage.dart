import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/features/common/AppBars.dart';



import 'package:iphmenu/Theme.dart' as Theme;

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key: key);

  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _controller = new TextEditingController();

  var loginScreen;
  bool isSetup;


  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        isSetup = prefs.getBool('isSetup') ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar("Admin"), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[
          (isSetup)? _loginAdmin() : _setupAdmin()
        ],
      ),
    );
  }

  Widget _setupAdmin(){

    return new Column(
      children: <Widget>[
        new TextField(
          controller:  _controller,
          decoration: new InputDecoration(
            labelText: "Please enter a pin: ",
            hintText: '',
          ),
        ),
        new RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title: new Text('What you typed'),
                content: new Text(_controller.text),
              ),
            );
          },
          child: new Text('SUBMIT'),
        ),
      ],
    );
  }

  Widget _loginAdmin() {
    return new Column(
      children: <Widget>[
        new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            labelText: "Enter your pin: ",
            hintText: 'Your Admin Pin',
          ),
        ),
        new RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) =>
              new AlertDialog(
                title: new Text('What you typed'),
                content: new Text(_controller.text),
              ),
            );
          },
          child: new Text('SUBMIT'),
        ),
      ],
    );
  }
}