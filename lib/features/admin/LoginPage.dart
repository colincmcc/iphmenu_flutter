import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/features/common/AppBars.dart';
import 'package:iphmenu/features/homepage/HomePageLiquor.dart';



import 'package:iphmenu/Theme.dart' as Theme;

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key: key);

  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final TextEditingController _controller = new TextEditingController();

  var loginScreen;
  bool isSetup;
  bool isAdmin;
  int adminPin;
  int _step;



  String _adminFirstPinEntry;
  String _adminSecondPinEntry;

  String _labelText = "Please enter a pin: ";
  String _validatorMessage = "";



  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSetup = prefs.getBool("isSetup") ?? false;
    adminPin = prefs.getInt("adminPin");
    isAdmin = prefs.getBool("isAdmin") ?? false;
    print("isSetup = $isSetup");
    print("admin pin = $adminPin");
    print("isAdmin = $isAdmin");
    setState(() {
      _step = 1;
      if(isSetup) {
        _labelText = "Please enter your Pin: ";
        _step = 3;
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
      print("isSetup = $isSetup");
      print("admin pin = $adminPin");
    });
  }
  Future<Null> checkLogin(String _submittedPin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int submittedPin = int.parse(_submittedPin);
    setState(() {
      int adminPin = prefs.getInt("adminPin");
      if(submittedPin == adminPin) {
        prefs.setBool("isAdmin", true);
        isAdmin = prefs.getBool("isAdmin");
        print ("isAdmin = $isAdmin");
        _validatorMessage = "Success!  You are now logged in!";
        Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new HomePageLiquor(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        );
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
    print("first pin = $_adminFirstPinEntry");
    print("second pin = $_adminSecondPinEntry");
    print("is setup = $isSetup");
    print("admin pin = $adminPin");
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
              switch (_step) {
                case 1:
                  return _validateFirstAdminPin(_controller.text);
                case 2:
                  return _validateSecondAdminPin(_controller.text);
                case 3:
                  return checkLogin(_controller.text);
              }
              /*
              if(_adminFirstPinEntry == null && isSetup == false){
                _validateFirstAdminPin(_controller.text); }
              if(_adminSecondPinEntry == null && isSetup == false){
                _validateSecondAdminPin(_controller.text);}
              else{
                checkLogin(_controller.text);}
                */
              print("first pin = $_adminFirstPinEntry");
              print("second pin = $_adminSecondPinEntry");
              print("is setup = $isSetup");
              print("admin pin = $adminPin");

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
      _step = 2;
      print("submit first");
    });
  }
  _submitSecondPin(String _adminPin){
    setSharedPrefs(_adminPin);
    _controller.clear();
    setState((){
      _validatorMessage = "Thank you!  The admin pin is set.";
      _step = 3;
      Navigator.of(context).push(
        new PageRouteBuilder(
          pageBuilder: (_, __, ___) => new HomePageLiquor(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          new FadeTransition(opacity: animation, child: child),
        ) ,
      );
      print("submit second");

    });
  }

  _submitLogin(String adminPin){

  }
  _resetForm(){
    _controller.clear();
    setState((){
      _adminFirstPinEntry = null;
      _labelText = "Please enter a pin: ";
      _step = 1;
      print("reset");

    });

  }

  _validateFirstAdminPin(String value) {
    print("validate first");

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
      _adminSecondPinEntry = value;
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
      else {
        _step = 3;
        _submitSecondPin(value);
      }
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

