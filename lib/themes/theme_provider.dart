import 'package:chats/themes/dark_mode.dart';
import 'package:chats/themes/ligth_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  bool get idDarkMode => _themeData == darkMode;
  
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode)
    {
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}