
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/edit_task_screen.dart';
import 'package:task_app/screens/history_completed_task_screen.dart';
import 'package:task_app/screens/history_screen.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/new_task_screen.dart';
import 'package:task_app/screens/signIn_screen.dart';
import 'package:task_app/viewmodels/history_completed_task_viewmodel.dart';
import 'package:task_app/viewmodels/history_viewmodel.dart';
import 'package:task_app/viewmodels/login_viewmodel.dart';
import 'package:task_app/viewmodels/new_task_viewmodel.dart';

import 'providers/generalAppInfo.dart';
import 'screens/login_screen.dart';
import 'viewmodels/edit_task_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/sigin_viewmodel.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        //hay que registrar todos los viewmodels por que sino truena cuando se quieran
        //instanciar en el Widget Build de las screens
        ChangeNotifierProvider(create: (context) =>GeneralAppInfo()),
        ChangeNotifierProvider(create:(context)=>LoginViewModel()),
        ChangeNotifierProvider(create:(context)=>SigninViewModel()),
        ChangeNotifierProvider(create:(context)=>HomeViewModel()),
        ChangeNotifierProvider(create:(context)=>NewTaskViewModel()),
        ChangeNotifierProvider(create:(context)=>EditTaskViewModel()),
        ChangeNotifierProvider(create:(context)=>HistoryViewModel()),
        ChangeNotifierProvider(create:(context)=>HistoryCompletedTaskViewModel()),

      ],
      child: MaterialApp(
        title: "Movies",
        debugShowCheckedModeBanner: false,
       /* home:
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: const LoginScreen(),

        ),*/
        initialRoute: '/login',
        routes:
        {

          LoginScreen.routeName:(context) => const LoginScreen(),
          SigninScreen.routeName:(context) => const SigninScreen(),
          HomeScreen.routeName:(context) => const HomeScreen(),
          NewTaskScreen.routeName:(context) => const NewTaskScreen(),
          EditTaskScreen.routeName:(context) => const EditTaskScreen(),
          HistoryScreen.routeName:(context) => const HistoryScreen(),
          HistoryCompletedTaskScreen.routeName:(context) => const HistoryCompletedTaskScreen(),
          //NominaDescriptionScreen.routeName:(context) => NominaDescriptionScreen(),
          //NominaListScreen.routeName:(context) => NominaListScreen()
        },
      ),
    );
  }

}