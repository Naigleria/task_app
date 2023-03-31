
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../ui/UIHelper.dart';

class SigninViewModel extends ChangeNotifier {

  bool passwordVisible=false;
  bool password2Visible=false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();


  void changePassVisibility(){
    passwordVisible=!passwordVisible;
    notifyListeners();
  }
  void changePass2Visibility(){
    password2Visible=!passwordVisible;
    notifyListeners();
  }













}
