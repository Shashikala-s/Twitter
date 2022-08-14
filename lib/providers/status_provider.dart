import 'package:flutter/material.dart';

class StatusProvider with ChangeNotifier{

  bool logStatus=false;
  void setLogin(bool value){

    logStatus=value;
    notifyListeners();
  }

}