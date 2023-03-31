


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/viewmodels/home_viewmodel.dart';

import '../models/task.dart';
import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';


class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen> {


  @override
  initState() {

    Provider.of<HomeViewModel>(context, listen: false).getAllTasks();
    //Provider.of<HomeViewModel>(context, listen: false).passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    HomeViewModel homeVM = Provider.of<HomeViewModel>(context);
    final generalAppInfo = Provider.of<GeneralAppInfo>(context);

    print("Widget Build");
    //loginVM.usernameController.clear();
    //loginVM.passwordController.clear();

    Future<void> showDialogDeleteTask(int index, Tarea tempTask, BuildContext context, int? id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: UIHelper.primaryBlueCard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            content: SingleChildScrollView(
              child: Column(
                children:   <Widget>[
                  UIHelper.getText("¿Seguro que quiere eliminar", 15.0, UIHelper.darkBlueTextCard),
                  UIHelper.getText("ésta tarea?", 15.0, UIHelper.darkBlueTextCard),
                  const SizedBox(height: 10.0,),
                  UIHelper.getText("No podrás recuperar las tareas", 15.0, UIHelper.primaryBlueBold),
                  UIHelper.getText("eliminadas", 15.0, UIHelper.primaryBlueBold),
                  const SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.getElevatedButton(
                        null,
                        12.0,
                        "No",
                        100.0,
                        35.0,
                        0.0,
                        BorderSide(color: UIHelper.primaryOrange, width: 1),
                        Colors.white,
                        (){
                          setState(() {
                            homeVM.tasksList.insert(index, tempTask);
                          });
                          Navigator.of(context).pop();
                        },
                        15.0,
                        UIHelper.primaryOrange,

                      ),
                      UIHelper.getElevatedButton(
                        null,
                        12.0,
                        "Sí",
                        100.0,
                        35.0,
                        0.0,
                        BorderSide.none,
                        UIHelper.primaryBlueBold,
                        ()async{
                          int rowsAfected = await homeVM.deleteTask(context, id!);
                          print("Number of tasks deleted: $rowsAfected");
                          homeVM.getAllTasks();
                          Navigator.of(context).pop();
                        },
                        15.0,
                        Colors.white

                      )

                    ],
                  )
                ],
              ),
            ),

          );
        },
      );
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
        body: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: UIHelper.getText("Home", 24.0, Colors.white, FontWeight.bold),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 20.0,),

            homeVM.tasksList.length>0?
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,

                itemExtent: 200.0,
                itemCount: homeVM.tasksList.length,
                itemBuilder: (context, index){
                  //se tiene que tener acceso a los demas booleanos para setearlos en false
                  //bool checkIndex =false;


                  final item = homeVM.tasksList[index].id.toString();
                  return Padding(
                    padding:  EdgeInsets.only(
                      top: index==0 ? 0.0:10.0,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 20.0,),

                        Expanded(
                          child: InkWell(
                            child: Dismissible(
                              key: Key(item),
                              onDismissed: (direction){
                                Tarea? tempTask;
                                setState(() {
                                  tempTask= homeVM.tasksList[index];
                                  homeVM.tasksList.removeAt(index);
                                });
                                showDialogDeleteTask(index, tempTask!, context, tempTask!.id);
                              },
                              child: Card(
                                color: UIHelper.primaryBlueCard,
                                shadowColor: Colors.blueGrey,
                                elevation: 3,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10.0,),
                                    Row(
                                      children:  [
                                        const SizedBox(width: 10.0,),
                                        CircleAvatar(
                                          radius: 32.0,
                                          backgroundImage: FileImage(File(homeVM.tasksList[index].imagen)),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        UIHelper.getText(homeVM.tasksList[index].titulo, 17.0, UIHelper.darkBlueTextCard, FontWeight.bold)
                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10.0,),
                                        Flexible(
                                          child: UIHelper.getText(homeVM.tasksList[index].descripcion,
                                            15.0,
                                            UIHelper.darkBlueTextCard
                                          ),
                                        ),
                                        const SizedBox(width: 10.0,),
                                      ],
                                    ),

                                    const Spacer(),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10.0,),
                                        UIHelper.getText(homeVM.tasksList[index].estatus, 15.0, UIHelper.darkBlueTextCard, FontWeight.bold),
                                        Expanded(child: Container()),
                                        UIHelper.getText(homeVM.tasksList[index].fechaCreacion, 15.0, UIHelper.darkBlueTextCard, FontWeight.bold),
                                        const SizedBox(width: 10.0,),

                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.pushReplacementNamed(context, '/edit_task',
                                arguments: {
                                  "edit_task": homeVM.tasksList[index]
                                }
                              );

                            },
                          )
                        ),
                        const SizedBox(width: 20.0,)
                      ],
                    ),
                  );
                },

              ),
            ):Expanded(

              child: Center(
                child: UIHelper.getText("No hay tareas pendientes", 17.0, UIHelper.darkBlueTextCard)
              ),
            )


          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 80.0,
          width: 80.0,
          child: FloatingActionButton(

            backgroundColor: UIHelper.primaryOrange,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/new_task');
            },
            elevation: 0.0,
            child: SvgPicture.asset('assets/svg/stroke_width_add.svg', height: 40.0, width: 40.0,),

          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
             boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)]
          ),
          child: BottomAppBar(

            height: 70.0,
            color: UIHelper.primaryBlueCard,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  IconButton(
                    icon: SvgPicture.asset('assets/svg/filled_paper.svg'),
                    iconSize: 30.0,
                    onPressed: (){

                    }
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(''),
                  ),

                  IconButton(
                    icon: SvgPicture.asset('assets/svg/check.svg'),
                    iconSize: 30.0,
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/history');
                    }
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );



  }




}