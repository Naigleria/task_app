import 'package:flutter/material.dart';

class GeneralAppInfo with ChangeNotifier{

  String _taskName='';

  String get taskName{
    return _taskName;
  }

  set catalogMovie(String value){
    _taskName=value;
    notifyListeners();
  }
}