
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

class NewTaskViewModel extends ChangeNotifier {

  bool emptyImage=true;
  String imagePath="";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();


  void changePassVisibility(){

    notifyListeners();
  }

  void getImageFromGallery()async{
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final  pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      /*
      if(imagePath!=""){
        print("ELIMINANDD FOTO PREVIA");
        final File file = File(imagePath);
        file.deleteSync();
      }*/
      imagePath=pickedImage.path;

    } else {
      print('No se ha seleccionado ninguna imagen.');
    }
    notifyListeners();
  }

  Future<int?> insertNewTask(BuildContext context) async {

    final task= Tarea(

      titulo: titleController.text,
      descripcion:descriptionController.text,
      fechaCreacion: "${dayController.text}/${monthController.text}/${yearController.text}",
      estatus: "Pendiente",
      fechaTermino: "",
      imagen: imagePath,
    );

    final tareaDao = TareaDAO();

    try{
      int? taskIdCreated = await tareaDao.insert(task);
      print("Tarea creada exitosamente $taskIdCreated");
      final snackBar = UIHelper.getSnackBar("Bien!", "Tarea creada exitosamente", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      return taskIdCreated;
    }catch(e){
      final snackBar = UIHelper.getSnackBar("Error!", "Error al intentar crear la tarea", ContentType.failure);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return 0;
    }


  }












}