


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/viewmodels/home_viewmodel.dart';

import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';
import '../viewmodels/new_task_viewmodel.dart';


class NewTaskScreen extends StatefulWidget {
  static String routeName = '/new_task';
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  NewTaskScreenState createState() => NewTaskScreenState();
}


class NewTaskScreenState extends State<NewTaskScreen> {


  @override
  initState() {
    Provider.of<NewTaskViewModel>(context, listen: false).titleController.clear();
    Provider.of<NewTaskViewModel>(context, listen: false).descriptionController.clear();
    Provider.of<NewTaskViewModel>(context, listen: false).dayController.clear();
    Provider.of<NewTaskViewModel>(context, listen: false).monthController.clear();
    Provider.of<NewTaskViewModel>(context, listen: false).yearController.clear();
    Provider.of<NewTaskViewModel>(context, listen: false).imagePath="";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    NewTaskViewModel newTaskVM = Provider.of<NewTaskViewModel>(context);
    final generalAppInfo = Provider.of<GeneralAppInfo>(context);

    print("Widget Build");
    //loginVM.usernameController.clear();
    //loginVM.passwordController.clear();




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
                          UIHelper.getText("New Task", 24.0, Colors.white, FontWeight.bold),
                          const Spacer(),
                          const SizedBox(width: 40.0,),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                newTaskVM.imagePath==""?
                InkWell(
                  child: SvgPicture.asset('assets/svg/new_task_empty_image.svg'),
                  /*
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: FileImage(File("")),
                  ),
                  */
                  onTap: (){
                    newTaskVM.getImageFromGallery();
                  },
                ):

                InkWell(
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: FileImage(File(newTaskVM.imagePath)),
                  ),
                  onTap: (){
                    newTaskVM.getImageFromGallery();
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
                        controller: newTaskVM.titleController,
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
                        style: TextStyle(
                          color: UIHelper.darkBlueTextCard
                        ),
                        controller: newTaskVM.descriptionController,
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
                        maxLines: 5,
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
                        controller: newTaskVM.dayController,
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
                        controller: newTaskVM.monthController,
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
                        controller: newTaskVM.yearController,
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

                const SizedBox(height: 60.0,),

                Row(
                  children: [
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: UIHelper.getElevatedButton(
                        SvgPicture.asset('assets/svg/white_check.svg'),
                        10.0,
                        "Crear",
                        null,
                        60.0,
                        null,
                        BorderSide.none,
                        UIHelper.primaryBlueBold,
                        () async{


                          int? id = await newTaskVM.insertNewTask(context);

                          if(id!>-1){
                            if(!mounted)return;

                              Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        17.0,
                        Colors.white,
                        FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                const SizedBox(height: 20.0,),

              ],
            ),
          ),
        ),
      ),
    );



  }




}