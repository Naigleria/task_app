
import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;


import '../dao/task_dao.dart';
import '../models/task.dart';
import '../ui/UIHelper.dart';

class EditTaskViewModel extends ChangeNotifier {
  //dynamic bytes =0;
  bool isDataSet=false;
  String imagePath="";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  void getImageFromGallery()async{
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final  pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      /*
      if(imagePath!=""){
        print("ELIMINANDD FOTO PREVIA");
        final File file = File(imagePath);
        file.deleteSync();
      }*/
      imagePath=pickedImage.path;
      print(pickedImage.path);
    } else {
      print('No se ha seleccionado ninguna imagen.');
    }
    notifyListeners();
  }

  Future<int?> updateTask(BuildContext context,  int? id, String typeOfUpdate) async {

    final task= Tarea(
      id: id,
      titulo: titleController.text,
      descripcion:descriptionController.text,
      fechaCreacion: "${dayController.text}/${monthController.text}/${yearController.text}",
      estatus: typeOfUpdate=="onlyUpdate"? "Pendiente":"Terminado",
      fechaTermino: typeOfUpdate=="onlyUpdate"? "":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
      imagen:imagePath,
    );

    final tareaDao = TareaDAO();

    try{
      int? changesMade = await tareaDao.update(task);

      final snackBar = UIHelper.getSnackBar(
        "Bien!",
        typeOfUpdate=="onlyUpdate"?
        "Tarea actualizada exitosamente":
        "Tarea terminada exitosamente, dirígete a la sección de tareas copletadas para verificarla",
        ContentType.success
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      return changesMade;
    }catch(e){
      final snackBar = UIHelper.getSnackBar("Error!", "Error al intentar actualizadar tarea", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return 0;
    }

  }

  void changePassVisibility(){

    notifyListeners();
  }












}