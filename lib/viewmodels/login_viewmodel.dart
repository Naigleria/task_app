
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../ui/UIHelper.dart';

class LoginViewModel extends ChangeNotifier {

  bool passwordVisible=false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void changePassVisibility(){
    passwordVisible=!passwordVisible;
    notifyListeners();
  }










}
