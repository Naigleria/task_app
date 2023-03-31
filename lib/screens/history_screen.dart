


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/viewmodels/history_viewmodel.dart';
import 'package:task_app/viewmodels/home_viewmodel.dart';

import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';


class HistoryScreen extends StatefulWidget {
  static String routeName = '/history';
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}


class HistoryScreenState extends State<HistoryScreen> {


  @override
  initState() {
    Provider.of<HistoryViewModel>(context, listen: false).getAllTasks();
    //Provider.of<HistoryViewModel>(context, listen: false).passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    HistoryViewModel historyVM = Provider.of<HistoryViewModel>(context);
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
                      child: UIHelper.getText("Completadas", 24.0, Colors.white, FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 20.0,),

            historyVM.tasksListHistory.length>0?
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemExtent: 200.0,
                itemCount: historyVM.tasksListHistory.length,
                itemBuilder: (context, index){
                  //se tiene que tener acceso a los demas booleanos para setearlos en false
                  //bool checkIndex =false;
                  return Padding(
                    padding:  EdgeInsets.only(
                      top: index==0 ? 0.0:10.0,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 20.0,),

                        Expanded(
                          child: InkWell(
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
                                          backgroundImage: FileImage(File(historyVM.tasksListHistory[index].imagen)),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        UIHelper.getText(historyVM.tasksListHistory[index].titulo, 17.0, UIHelper.darkBlueTextCard, FontWeight.bold)
                                      ],
                                    ),
                                  const SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      Flexible(
                                          child: UIHelper.getText(historyVM.tasksListHistory[index].descripcion,
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
                                        UIHelper.getText(historyVM.tasksListHistory[index].estatus, 15.0, UIHelper.primaryBlueLight, FontWeight.bold),
                                        Expanded(child: Container()),
                                        UIHelper.getText(historyVM.tasksListHistory[index].fechaCreacion, 15.0, UIHelper.darkBlueTextCard, FontWeight.bold),
                                        const SizedBox(width: 10.0,),

                                      ],
                                    ),
                                  const SizedBox(height: 10.0,),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.pushReplacementNamed(context, '/history_completed_task',
                                arguments: {
                                  "completed_task": historyVM.tasksListHistory[index]
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
                child: UIHelper.getText("No hay tareas completadas", 17.0, UIHelper.darkBlueTextCard)
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
                    icon: SvgPicture.asset('assets/svg/paper.svg'),
                    iconSize: 30.0,
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(''),
                  ),

                  IconButton(
                    icon: SvgPicture.asset('assets/svg/rounded_check.svg'),
                    iconSize: 30.0,
                    onPressed: (){

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