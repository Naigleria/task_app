
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../dao/task_dao.dart';
import '../models/task.dart';
import '../ui/UIHelper.dart';

class HomeViewModel extends ChangeNotifier {

  List<Tarea> tasksList=[];

  Future<List<Tarea>> getAllTasks() async {
    tasksList.clear();
    final tareaDao = TareaDAO();
    tasksList =await tareaDao.getAllByStatus("Pendiente");
    notifyListeners();
    return tasksList;
  }

  Future<int> deleteTask(BuildContext context, int id) async {

    final tareaDao = TareaDAO();
    try{
      int rowsAfected =await tareaDao.delete(id);
      final snackBar = UIHelper.getSnackBar("Bien!", "Tarea eliminada exitosamente", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      notifyListeners();
      return rowsAfected;
    }catch(e){
      final snackBar = UIHelper.getSnackBar("Error!", "Error al intentar eliminar tarea", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
        return 0;
    }


  }









}