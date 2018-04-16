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
  int adminPin;


  String _adminFirstPinEntry;
  String _adminSecondPinEntry;

  String _labelText = "Please enter a pin: ";
  String _validatorMessage = "";



  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSetup = prefs.getBool("isSetup");
    adminPin = prefs.getInt("adminPin");
    setState(() {
      if(isSetup) {
        _labelText = "Please enter your Pin: ";
      }
    });
  }
  Future<Null> setSharedPrefs(String _adminPin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int adminPin = int.parse(_adminPin);
    setState(() {
      prefs.setBool("isSetup", true);
      prefs.setInt("adminPin", adminPin);

      isSetup = prefs.getBool("isSetup");
      adminPin = prefs.getInt("adminPin");
      print(isSetup);
      print(adminPin);
    });
  }
  Future<Null> checkLogin(String _submittedPin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int submittedPin = int.parse(_submittedPin);
    setState(() {
      int adminPin = prefs.getInt("adminPin");
      if(submittedPin == adminPin) {
        prefs.setBool("isAdmin", true);
        _validatorMessage = "Success!  You are now logged in!";

      }
      else
        _validatorMessage = "Incorrect Pin.  Please Try again.";
    });
    _controller.clear();
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
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 76.0, 16.0, 16.0),
            child: new TextField(
              controller:  _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: new InputDecoration(
                labelText: _labelText,
                hintText: 'Enter Pin',

              ),
            ),
          ),

          new Container(height: 8.0,),
          new Text('$_validatorMessage'),
          new Container(height: 8.0,),
          new RaisedButton(
            onPressed: () {
              if(_adminFirstPinEntry == null && isSetup != true)
                _validateFirstAdminPin(_controller.text);
              if(_validateSecondAdminPin == null && isSetup != true)
                _validateSecondAdminPin(_controller.text);
              else
                checkLogin(_controller.text);
              print(_adminFirstPinEntry);
              print(_adminSecondPinEntry);
              print(isSetup);
              print("$adminPin");

            },
            child: new Text('SUBMIT'),
          ),
          ]
          ),
    );
  }
  _submitFirstPin(String value){
    setState(() {
      _adminFirstPinEntry = value;
      _labelText = "Re-enter Pin: ";
    });
  }
  _submitSecondPin(String _adminPin){
    setSharedPrefs(_adminPin);
    _controller.clear();
    setState((){
      _validatorMessage = "Thank you!  The admin pin is set.";
    });
  }

  _submitLogin(String adminPin){

  }
  _resetForm(){
    _controller.clear();
    setState((){
      _adminFirstPinEntry = null;
      _labelText = "Please enter a pin: ";
    });

  }

  _validateFirstAdminPin(String value) {
    setState(() {
      if (value.isEmpty)
        _validatorMessage = 'Pin is required.';
      final RegExp pinExp = new RegExp(r'[0-9]{4}');
      if (!pinExp.hasMatch(value))
        _validatorMessage = 'Please enter a 4 digit numerical pin.';
      else {
        _submitFirstPin(value);
        _controller.clear();
      }
    });
  }

  _validateSecondAdminPin(String value){

    setState(() {
      if (value.isEmpty) {
        _validatorMessage = 'Pin is required.';
      }
      final RegExp pinExp = new RegExp(r'[0-9]{4}');
      if (!pinExp.hasMatch(value))
        _validatorMessage = 'Please enter a 4 digit numerical pin.';
      if (value != _adminFirstPinEntry){
        _validatorMessage = 'Pins do not match';
        _resetForm();
      }
      else
        _submitSecondPin(value);
    });
  }

  Widget _setupAdmin() {
    return new Column(
      children: <Widget>[

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

