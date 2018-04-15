import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/modal/LiquorItem.dart';



  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //
  // LIQUOR LIST
  //
  getLiquorList(String _liquorJson){
   String _liquorJson = prefs.getString("masterLiquorList");
   List<LiquorItem> liquorList = (_liquorJson as List).map((i) => new LiquorItem.fromJson(i));

   return liquorList;
  }

  setLiquorList(List<LiquorItem> _liquorItemList){
  List<LiquorItem> _liquorItemList;
  String _liquorJson = json.encode(_liquorItemList);
  bool _success;

  prefs.setString("masterLiquorList", _liquorJson).then((bool success){
    _success = true;
  });

  return _success;
  }


  //
  // ADMIN INFO
  //
  getAdminStatus(){
    bool _isAdmin = prefs.getBool("isAdmin");
    return _isAdmin;
  }

  setAdminStatus(bool _adminStatus){
    bool _success;

    prefs.setBool("isAdmin", _adminStatus).then((bool success){
      _success = true;
    });

    return _success;
  }

  getAdminPin(){
    int _adminPin = prefs.getInt("adminPin");
    return _adminPin;
  }

  setAdminPin(int _adminPin){
    bool _success;

    prefs.setInt("adminPin", _adminPin).then((bool success){
      _success = true;
    });

    return _success;
  }


  //
  //SETUP STATUS
  //
  getSetupStatus()  {
    final SharedPreferences prefs = await _prefs;

    bool _isSetup = prefs.getBool("isSetup");

    return _isSetup;

    }

  setSetupStatus(bool _isSetup){
    bool _success;

    prefs.setBool("isSetup", _isSetup).then((bool success){
      _success = true;
    });

    return _success;
  }

