import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../dao/task_dao.dart';
import '../models/task.dart';
import '../ui/UIHelper.dart';

class HistoryViewModel extends ChangeNotifier {
  List<Tarea> tasksListHistory=[];

  Future<List<Tarea>> getAllTasks() async {

    final tareaDao = TareaDAO();
    tasksListHistory =await tareaDao.getAllByStatus("Terminado");
    notifyListeners();
    return tasksListHistory;
  }












}