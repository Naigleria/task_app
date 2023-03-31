
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../ui/UIHelper.dart';

class HistoryCompletedTaskViewModel extends ChangeNotifier {

  String imagePath="";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController dayFinishedController = TextEditingController();
  final TextEditingController monthFinishedController = TextEditingController();
  final TextEditingController yearFinishedController = TextEditingController();


  void changePassVisibility(){

    notifyListeners();
  }












}