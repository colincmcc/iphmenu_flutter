// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _isSetup;
  Future<bool> _isAdmin;
  Future<String> _adminUid;

  Future<String> _message = new Future<String>.value('');

/*

  Future<String> _setupGoogleUser() async {
    final SharedPreferences prefs = await _prefs;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    _adminUid = prefs.setString("adminUid", user.uid).then((bool success) {
      return _adminUid;
    });

    return 'Google Sign-in succeeded for ${user.displayName}.  Admin Mode is turned on.';
  }

  Future<String> _loginGoogleUser() async {
    final SharedPreferences prefs = await _prefs;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    _adminUid = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('adminUid'));
    });
    if (_adminUid == user.uid) {
      _loginUser();
      return 'Google Sign-in succeeded for ${user
          .displayName}.  Admin Mode is turned on.';
    }
  }
*/
  @override
  void initState() {
    super.initState();
    _isSetup = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('isSetup')) ?? false;
    });
    print (_isSetup.value);
  }

  // If the user hasn't been setup yet, initiate a new user
  _setupUser() async {
    final SharedPreferences prefs = await _prefs;

    return new Column(
      children: <Widget>[
        new Text("setup user")
      ],
    );

  }

  // Login user
  _loginUser() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isAdmin = prefs.setBool("isAdmin", true).then((bool success) {
        return _isAdmin;

      });
    });
  }

  // Change the admin Google user

  _changeAdminUser() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isSetup = prefs.setBool("isSetup", false).then((bool success) {
        return _isSetup;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (_isSetup == false) ? new Text("isSetup is False") : new Text("isSetup is True"),
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
                      return (snapshot.data == false) ? new LoginScreen() : new SetupScreen();

                    }
                }
              ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Column(
          children: <Widget>[
            new Text("")
          ],
        )
    );
  }
}
class SetupScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Column(
          children: <Widget>[
            new Text("To intialize admin features, please sign in with the Google account associated with the admin."),
            /*
            new RaisedButton(
              child: const Text('Sign In'),
              onPressed: (){
                _setupUser();
                print(snapshot.data);
              },
            ) */
          ],
        )
    );
  }
}