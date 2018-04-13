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
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _isSetup;
  Future<int> _isAdmin;
  Future<String> _adminUid;

  Future<String> _message = new Future<String>.value('');

  Future<String> _testSignInAnonymously() async {
    final FirebaseUser user = await _auth.signInAnonymously();
    assert(user != null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);
    if (Platform.isIOS) {
      // Anonymous auth doesn't show up as a provider on iOS
      assert(user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      // Anonymous auth does show up as a provider on Android
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
      assert(user.providerData[0].displayName == null);
      assert(user.providerData[0].photoUrl == null);
      assert(user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInAnonymously succeeded: $user';
  }

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
      return 'Google Sign-in succeeded for ${user
          .displayName}.  Admin Mode is turned on.';
    }
  }

  @override
  void initState() {
    super.initState();
    _isSetup = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('isSetup') ?? 0);
    });
  }

  // If the user hasn't been setup yet, initiate a new user
  _setupLogin() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isSetup = prefs.setInt("isSetup", 1).then((bool success) {
        return _isSetup;
      });
    });
  }

  // Login user
  _loginUser() async {
    final SharedPreferences prefs = await _prefs;

    
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
          _setupLogin(),
          new MaterialButton(
              child: const Text('Sign In with Google'),
              onPressed: () {
                _loginUser();
                setState(() {
                  _message = _loginGoogleUser();
                });
              }),
          new FutureBuilder<String>(
              future: _message,
              builder: (_, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data ?? '',
                    style: const TextStyle(
                        color: const Color.fromARGB(255, 0, 155, 0)));
              }),
        ],
      ),
    );
  }
}
