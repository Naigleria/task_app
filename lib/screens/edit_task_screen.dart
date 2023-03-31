


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/viewmodels/edit_task_viewmodel.dart';
import 'package:task_app/viewmodels/home_viewmodel.dart';

import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';
import '../viewmodels/new_task_viewmodel.dart';


class EditTaskScreen extends StatefulWidget {
  static String routeName = '/edit_task';
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  EditTaskScreenState createState() => EditTaskScreenState();
}


class EditTaskScreenState extends State<EditTaskScreen> {



  @override
  initState() {

    Provider.of<EditTaskViewModel>(context, listen: false).titleController.clear();
    Provider.of<EditTaskViewModel>(context, listen: false).descriptionController.clear();
    Provider.of<EditTaskViewModel>(context, listen: false).dayController.clear();
    Provider.of<EditTaskViewModel>(context, listen: false).monthController.clear();
    Provider.of<EditTaskViewModel>(context, listen: false).yearController.clear();
    Provider.of<EditTaskViewModel>(context, listen: false).imagePath="";
    Provider.of<EditTaskViewModel>(context, listen: false).isDataSet=false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    EditTaskViewModel editTaskVM = Provider.of<EditTaskViewModel>(context);
    final generalAppInfo = Provider.of<GeneralAppInfo>(context);
    final dynamic receivedData = ModalRoute.of(context)!.settings.arguments;
    final Tarea editTask =receivedData["edit_task"];

    if(!editTaskVM.isDataSet){
      print("seteando datos");
      editTaskVM.titleController.text=editTask.titulo;
      editTaskVM.descriptionController.text=editTask.descripcion;
      List<String> dayMonthYear= editTask.fechaCreacion.split("/");
      editTaskVM.dayController.text=dayMonthYear[0];
      editTaskVM.monthController.text=dayMonthYear[1];
      editTaskVM.yearController.text=dayMonthYear[2];
      editTaskVM.imagePath=editTask.imagen;
      editTaskVM.isDataSet=true;

    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: UIHelper.primaryBlueBold
          ),
        ),

        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:   [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.transparent
                      ),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SvgPicture.asset('assets/svg/top_bar_blue_smaller.svg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          SizedBox(width: 20.0,),
                          IconButton(

                            icon: SvgPicture.asset('assets/svg/white_arrow_back.svg'),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, '/home');
                            }

                          ),
                          const Spacer(),
                          UIHelper.getText("Edit Task", 24.0, Colors.white, FontWeight.bold),
                          const Spacer(),
                          const SizedBox(width: 40.0,),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                 InkWell(
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage: FileImage(File(editTaskVM.imagePath)),

                    ),
                    onTap: (){
                      editTaskVM.getImageFromGallery();
                    },
                 ),
                const SizedBox(height: 10.0,),
                UIHelper.getText("Click para abrir galería", 15.0, UIHelper.primaryBlueBold),
                const SizedBox(height: 20.0,),
                Row(
                  children:  [
                    const SizedBox(width: 20.0,),
                    UIHelper.getText("Título", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                  ],
                ),
                const SizedBox(height: 4.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(

                        controller: editTaskVM.titleController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          hintText: "Escribe aquí el título de tu tarea",
                          hintStyle: TextStyle(color: UIHelper.primaryBlueLight),

                          //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                          prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),


                        ),

                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children:  [
                    const SizedBox(width: 20.0,),
                    UIHelper.getText("Descripción", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                  ],
                ),
                const SizedBox(height: 4.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(

                        controller: editTaskVM.descriptionController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          hintText: "Describe como será tu tarea",
                          hintStyle: TextStyle(color: UIHelper.primaryBlueLight),

                          //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                          prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),


                        ),
                        maxLines: 4,
                        maxLength: 100,
                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  children:  [
                    const SizedBox(width: 20.0,),
                    UIHelper.getText("Fecha", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                  ],
                ),
                const SizedBox(height: 4.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(
                        controller: editTaskVM.dayController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          hintText: "Día",
                          hintStyle: TextStyle(color: UIHelper.primaryBlueLight),

                          //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                          prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),


                        ),

                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(
                        controller: editTaskVM.monthController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          hintText: "Mes",
                          hintStyle: TextStyle(color: UIHelper.primaryBlueLight),

                          //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                          prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),


                        ),

                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(
                        controller: editTaskVM.yearController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(color: UIHelper.primaryBlueLight, width: 2.0),
                          ),
                          hintText: "Año",
                          hintStyle: TextStyle(color: UIHelper.primaryBlueLight),

                          //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                          prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),


                        ),

                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),

                const SizedBox(height: 40.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: UIHelper.getElevatedButton(
                        SvgPicture.asset('assets/svg/orange_pencil.svg'),
                        10.0,
                        "Actualizar",
                        null,
                        40.0,
                        0.0,
                        BorderSide(color: UIHelper.primaryOrange, width: 1),
                        Colors.white,
                        ()async {
                          int? rowsUpdated= await editTaskVM.updateTask(context, editTask.id, "onlyUpdate");
                          print("Rows updated: $rowsUpdated");
                          if(!mounted)return;
                            Navigator.pushReplacementNamed(context, '/home');
                        },
                        17.0,
                        UIHelper.primaryOrange,
                        FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: UIHelper.getElevatedButton(
                        SvgPicture.asset('assets/svg/white_check.svg'),
                        10.0,
                        "Completar Tarea",
                        null,
                        60.0,
                        null,
                        BorderSide.none,
                        UIHelper.primaryBlueBold,
                        ()async {
                          int? rowsUpdated= await editTaskVM.updateTask(context, editTask.id, "updateAndComplete");
                          print("Rows updated: $rowsUpdated");
                          if(!mounted)return;
                            Navigator.pushReplacementNamed(context, '/home');
                        },
                        17.0,
                        Colors.white,
                        FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                //const SizedBox(height: 20.0,),

              ],
            ),
          ),
        ),
      ),
    );



  }




}