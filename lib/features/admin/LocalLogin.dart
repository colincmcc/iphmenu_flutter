import 'dart:async';

import 'package:iphmenu/features/common/AppBars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/Theme.dart' as Theme;

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key: key);

  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _isSetup;
  Future<bool> _isAdmin;
  Future<int> _adminPin;
  var loginScreen;

  final GlobalKey<FormState> _formAdminKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _formScaffoldKey = new GlobalKey<ScaffoldState>();

  // Load initial value of isSetup and determine page layout based on value
  @override
  void initState() {
    super.initState();
    _isSetup = _prefs.then((SharedPreferences prefs) {
      print(prefs.getBool('isSetup'));
      (prefs.getBool('isSetup') == false) ? loginScreen = _adminSetupScreen() : loginScreen = _adminLoginScreen();
      return (prefs.getBool('isSetup')) ?? false;
    });
    _adminPin = _prefs.then((SharedPreferences prefs) {
      print(prefs.getInt('adminPin'));
      return (prefs.getInt('adminPin')) ?? null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(child: new GradientAppBar("Admin"), preferredSize: const Size.fromHeight(48.0)),
      body: new Column(
        children: <Widget>[
          new FutureBuilder<bool>(
              future: _isSetup,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return loginScreen;

                }
              }
          ),

        ],
      ),
    );
  }

  _setAdminPin(adminPin) async {
    final snackbar = new SnackBar(
      content: new Text('Pin is set to $adminPin'),
    );

    _formScaffoldKey.currentState.showSnackBar(snackbar);
    /*
    final SharedPreferences prefs = await _prefs;
    setState(() {

      _isSetup = prefs.setBool("isSetup", true).then((bool success) {
        return _isSetup;
      });

      _adminPin = prefs.setInt("adminPin", adminPin).then((bool success) {
        print("success, admin pin is $_adminPin");
        return _adminPin;
      });

    });
    */
  }
  _adminLoginScreen() {

    return new Container(
        child: new Text("admin login screen")
    );
  }


  _adminSetupScreen() {
    bool _formWasEdited = false;
    String _submittedPin;
    String _formLabel = "Enter Pin: ";
    String _buttonText = "Submit Pin";
    String _adminFirstPinEntry;
    bool _firstPinSubmitted;

    String _validateFirstAdminPin(String value){
      _formWasEdited = true;
      if (value.isEmpty)
        return 'Pin is required.';
      final RegExp pinExp = new RegExp(r'[0-9]{4}');
      if (!pinExp.hasMatch(value))
        return 'Please enter a 4 digit numerical pin.';
      return null;
    }
    String _validateSecondAdminPin(String value){
      _formWasEdited = true;
      if (value.isEmpty)
        return 'Pin is required.';
      final RegExp pinExp = new RegExp(r'[0-9]{4}');
      if (!pinExp.hasMatch(value))
        return 'Please enter a 4 digit numerical pin.';
      if (value != _adminFirstPinEntry)
        return 'Pins do not match.';
      return null;
    }
    void _submitFirst(){
      final form = _formAdminKey.currentState;

      if (form.validate()) {
        form.save();
        print(_adminFirstPinEntry);
        print(_submittedPin);
        setState(() {
          _firstPinSubmitted = true;
          _adminFirstPinEntry = _submittedPin;
        }
        );
        form.reset();
        // Email & password matched our validation rules
        // and are saved to _email and _password fields.
      }
    }
    _submitSecond(){
      final form = _formAdminKey.currentState;
      if (form.validate()) {
        form.save();
        String _adminSecondPinEntry = _submittedPin;
        form.reset();
        // Email & password matched our validation rules
        // and are saved to _email and _password fields.
        _setAdminPin(_submittedPin);

      }
    }


    TextFormField _firstPinForm = new TextFormField(
      decoration: new InputDecoration(labelText: "Enter Pin: "),
      validator: _validateFirstAdminPin,
      onSaved: (String val) {
        _submittedPin = val;
      },
      obscureText: true,
    );


    TextFormField _secondPinForm = new TextFormField(
      decoration: new InputDecoration(labelText: "Re-enter Pin: "),
      validator: _validateSecondAdminPin,
      onSaved: (String val) {
        _submittedPin = val;
      },
      obscureText: true,
    );


    return new Column(
     children: <Widget>[
       new Padding(
         padding: const EdgeInsets.all(16.0),
         child: new Form(
           key: _formAdminKey,
           child: new Column(
             children: <Widget>[
               (_firstPinSubmitted = true)? new Column(
                 children: <Widget>[
                   _secondPinForm,
                   new RaisedButton(
                     onPressed: _submitFirst,
                     child: new Text('submit second'),
                   ),
                 ],
               ): new Column(
                 children: <Widget>[
                   _firstPinForm,
                   new RaisedButton(
                     onPressed: _submitFirst,
                     child: new Text('submit first'),
                   ),
                 ],
               )

             ],
           ),
         ),
       )
     ],
    );
  }

  _updateAdminKey(){

  }
}
