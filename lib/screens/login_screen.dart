


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';


class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {


  @override
  initState() {
    Provider.of<LoginViewModel>(context, listen: false).usernameController.clear();
    Provider.of<LoginViewModel>(context, listen: false).passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    LoginViewModel loginVM = Provider.of<LoginViewModel>(context);
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
          child: Column(
            children:   [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,

                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SvgPicture.asset('assets/svg/login_waves_blue.svg'),
                ),
              ),
              const SizedBox(height: 100.0,),


              UIHelper.getText("Iniciar Sesión", 25.0, UIHelper.primaryBlueBold, FontWeight.bold),
              const SizedBox(height: 40.0,),
              Row(
                children:  [
                  const SizedBox(width: 20.0,),
                  UIHelper.getText("Nombre de Usuario", 12.0, UIHelper.primaryBlueBold, FontWeight.bold),
                ],
              ),
              const SizedBox(height: 4.0,),
              Row(
                children: [
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: TextField(
                      controller: loginVM.usernameController,
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
                        hintText: "Coloca tu nombre de Usuario",
                        hintStyle: TextStyle(color: UIHelper.primaryBlueLight),
                        prefixIcon:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset('assets/svg/figma_user.svg', height: 20.0, width: 20.0,),
                        ),
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
                children:  [
                  const SizedBox(width: 20.0,),
                  UIHelper.getText("Contraseña", 12.0, UIHelper.primaryBlueBold, FontWeight.bold),
                ],
              ),
              const SizedBox(height: 4.0,),
              Row(
                children: [
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: TextField(

                      controller: loginVM.passwordController,
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
                        hintText: "Escribe tu contraseña",
                        hintStyle: TextStyle(color: UIHelper.primaryBlueLight),
                        prefixIcon:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset('assets/svg/figma_padlock.svg', height: 20.0, width: 20.0,),
                        ),
                        //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                        prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        suffixIcon: IconButton(
                              iconSize: 40.0,
                              icon: loginVM.passwordVisible
                                ? SvgPicture.asset('assets/svg/figma_eye_off.svg')
                                : SvgPicture.asset('assets/svg/figma_eye.svg'),
                                onPressed: (){
                                  loginVM.changePassVisibility();

                                }
                            ),

                      ),
                      obscureText: loginVM.passwordVisible
                        ? false
                        : true,
                      textInputAction: TextInputAction.next,

                    ),
                  ),
                  const SizedBox(width: 20.0,),
                ],
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.getText("¿No tienes una cuenta?", 15.0, UIHelper.primaryBlueLight, FontWeight.bold)
                ],
              ),
              const SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.getText("Puedes ", 15.0, UIHelper.primaryBlueLight, FontWeight.bold),
                  InkWell(
                    child: UIHelper.getText("Crear una nueva", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                  ),
                ],
              ),
              Expanded(child: Container(),),
              Row(
                children: [
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: UIHelper.getElevatedButton(
                      null,
                      10.0,
                      "Continuar",
                      null,
                      60.0,
                      null,
                      BorderSide.none,
                      UIHelper.primaryBlueBold,
                      () {
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
              const SizedBox(height: 25.0,)
            ],
          ),
        ),
      ),
    );



  }




}