import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isloggedin');
  if(isLoggedIn == null || isLoggedIn == false){
    return false;
  }
  return true;
}
