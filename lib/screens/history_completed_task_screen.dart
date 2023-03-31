


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/viewmodels/home_viewmodel.dart';

import '../models/task.dart';
import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/history_completed_task_viewmodel.dart';
import '../viewmodels/login_viewmodel.dart';
import '../viewmodels/new_task_viewmodel.dart';


class HistoryCompletedTaskScreen extends StatefulWidget {
  static String routeName = '/history_completed_task';
  const HistoryCompletedTaskScreen({Key? key}) : super(key: key);

  @override
  HistoryCompletedTaskScreenState createState() => HistoryCompletedTaskScreenState();
}


class HistoryCompletedTaskScreenState extends State<HistoryCompletedTaskScreen> {


  @override
  initState() {
    //Provider.of<HistoryCompletedTaskViewModel>(context, listen: false).usernameController.clear();
    //Provider.of<HistoryCompletedTaskViewModel>(context, listen: false).passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    HistoryCompletedTaskViewModel historyCompletedTaskVM = Provider.of<HistoryCompletedTaskViewModel>(context);
    final generalAppInfo = Provider.of<GeneralAppInfo>(context);
    final dynamic receivedData = ModalRoute.of(context)!.settings.arguments;
    final Tarea completedTask =receivedData["completed_task"];


    print("seteando datos");
    historyCompletedTaskVM.titleController.text=completedTask.titulo;
    historyCompletedTaskVM.descriptionController.text=completedTask.descripcion;
    List<String> dayMonthYear= completedTask.fechaCreacion.split("/");
    historyCompletedTaskVM.dayController.text=dayMonthYear[0];
    historyCompletedTaskVM.monthController.text=dayMonthYear[1];
    historyCompletedTaskVM.yearController.text=dayMonthYear[2];

    List<String> dayMonthYearCompleted= completedTask.fechaTermino.split("/");
    historyCompletedTaskVM.dayFinishedController.text=dayMonthYearCompleted[0];
    historyCompletedTaskVM.monthFinishedController.text=dayMonthYearCompleted[1];
    historyCompletedTaskVM.yearFinishedController.text=dayMonthYearCompleted[2];
    historyCompletedTaskVM.imagePath=completedTask.imagen;







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
                              Navigator.pushReplacementNamed(context, '/history');
                            }

                          ),
                          const Spacer(),
                          UIHelper.getText("Completed Task", 24.0, Colors.white, FontWeight.bold),
                          const Spacer(),
                          const SizedBox(width: 40.0,),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: FileImage(File(completedTask.imagen)),
                ),
                //const SizedBox(height: 10.0,),
                //UIHelper.getText("Click para abrir galería", 15.0, UIHelper.primaryBlueBold),
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.titleController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.descriptionController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.dayController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.monthController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.yearController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                const SizedBox(height: 10.0,),
                Row(
                  children:  [
                    const SizedBox(width: 20.0,),
                    UIHelper.getText("Fecha de término", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                  ],
                ),
                const SizedBox(height: 4.0,),
                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: historyCompletedTaskVM.dayFinishedController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.monthFinishedController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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
                        readOnly: true,
                        controller: historyCompletedTaskVM.yearFinishedController,
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        decoration: InputDecoration(
                          fillColor: UIHelper.primaryBlueCard,
                          filled: true,
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


              ],
            ),
          ),
        ),
      ),
    );



  }




}