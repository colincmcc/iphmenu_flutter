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
  final TextEditingController _controller = new TextEditingController();
  var loginScreen;
  bool isSetup;
  String _adminFirstPinEntry;
  String _adminSecondPinEntry;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSetup = prefs.getBool("isSetup");
    setState(() {
      (isSetup)? loginScreen = _loginAdmin() : loginScreen = _setupAdmin();
    });
  }
  Future<Null> setSharedPrefs(String _adminPin, bool success) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int adminPin = int.parse(_adminPin);
    setState(() {
      prefs.setBool("isSetup", success);
      prefs.setInt("adminPin", adminPin);
      print(isSetup);
      print(adminPin);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar("Admin"), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[
          loginScreen ?? _setupAdmin()
        ],
      ),
    );
  }

  Widget _setupAdmin(){
    String _adminFirstPinEntry = "";
    String _adminSecondPinEntry = "";
    String _labelText = "Please enter a pin: ";
    String _validatorMessage;

    _submitFirstPin(String value){

      setState((){
        _adminFirstPinEntry = value;
        _labelText = "Re-enter Pin: ";
      });
      _controller.clear;

    }
    _submitSecondPin(String _adminPin, bool success){
        setSharedPrefs(_adminPin, success);
        _controller.clear();
        setState((){
          loginScreen = _loginAdmin();
        });
    }
    _resetForm(){
      _controller.clear();
      setState((){
        _adminFirstPinEntry = null;
      });

    }

    _validateFirstAdminPin(String value){
      setState((){
        if (value.isEmpty)
          _validatorMessage = 'Pin is required.';
        final RegExp pinExp = new RegExp(r'[0-9]{4}');
        if (!pinExp.hasMatch(value))
          _validatorMessage = 'Please enter a 4 digit numerical pin.';
        else
          _submitFirstPin(value);
      });

    }

    _validateSecondAdminPin(String value){
      if (value.isEmpty)
        _validatorMessage = 'Pin is required.';
      final RegExp pinExp = new RegExp(r'[0-9]{4}');
      if (!pinExp.hasMatch(value))
        _validatorMessage = 'Please enter a 4 digit numerical pin.';
      if (value != _adminFirstPinEntry){
        _validatorMessage = 'Pins do not match';
        _resetForm();
        }
      else
        _submitSecondPin(value, true);
    }

    return new Column(
      children: <Widget>[
        new TextField(
          controller:  _controller,
          decoration: new InputDecoration(
            labelText: _labelText ?? "",
            hintText: 'Enter Pin',
          ),
        ),
        new RaisedButton(
          onPressed: () {
            (_adminFirstPinEntry == "")?  _validateFirstAdminPin(_controller.text) : _validateSecondAdminPin(_controller.text);
            print(isSetup);
            print(_adminFirstPinEntry);
            print(_controller.text);
          },
          child: new Text('SUBMIT'),
        ),
        new Text(_validatorMessage ?? "")
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
          },
          child: new Text('SUBMIT'),
        ),
      ],
    );
  }
}