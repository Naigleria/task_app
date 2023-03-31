


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:task_app/viewmodels/sigin_viewmodel.dart';

import '../providers/generalAppInfo.dart';
import '../ui/UIHelper.dart';
import '../viewmodels/login_viewmodel.dart';


class SigninScreen extends StatefulWidget {
  static String routeName = '/signin';
  const SigninScreen({Key? key}) : super(key: key);

  @override
  SigninScreenState createState() => SigninScreenState();
}


class SigninScreenState extends State<SigninScreen> {


  @override
  initState() {
    Provider.of<SigninViewModel>(context, listen: false).usernameController.clear();
    Provider.of<SigninViewModel>(context, listen: false).passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SigninViewModel signinVM = Provider.of<SigninViewModel>(context);
    GeneralAppInfo generalAppInfo = Provider.of<GeneralAppInfo>(context);

    print("Widget Build");


    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: UIHelper.primaryOrange
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
                  child: SvgPicture.asset('assets/svg/signin_waves_orange.svg'),
                ),
              ),
              const SizedBox(height: 100.0,),

              UIHelper.getText("Crear una Cuenta", 25.0, UIHelper.primaryBlueBold, FontWeight.bold),
              const SizedBox(height: 30.0,),
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
                      controller: signinVM.usernameController,
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
                        hintText: "Escoge un nombre de Usuario",
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
              const SizedBox(height: 30.0,),
              Row(
                children:  [
                  const SizedBox(width: 20.0,),
                  UIHelper.getText("Escoge una Contraseña", 12.0, UIHelper.primaryBlueBold, FontWeight.bold),
                ],
              ),
              const SizedBox(height: 4.0,),
              Row(
                children: [
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: TextField(

                      controller: signinVM.passwordController,
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
                        hintText: "Contraseña mayor a 8 dígitos",
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
                              icon: signinVM.passwordVisible
                                ? SvgPicture.asset('assets/svg/figma_eye_off.svg')
                                : SvgPicture.asset('assets/svg/figma_eye.svg'),
                                onPressed: (){
                                  signinVM.changePassVisibility();

                                }
                            ),

                      ),
                      obscureText: signinVM.passwordVisible
                        ? false
                        : true,
                      textInputAction: TextInputAction.next,

                    ),
                  ),
                  const SizedBox(width: 20.0,),
                ],
              ),
              const SizedBox(height: 30.0,),
              Row(
                children:  [
                  const SizedBox(width: 20.0,),
                  UIHelper.getText("Confirma tu Contraseña", 12.0, UIHelper.primaryBlueBold, FontWeight.bold),
                ],
              ),
              const SizedBox(height: 4.0,),
              Row(
                children: [
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: TextField(

                      controller: signinVM.password2Controller,
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
                        hintText: "Verifica tu contraseña",
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
                              icon: signinVM.password2Visible
                                ? SvgPicture.asset('assets/svg/figma_eye_off.svg')
                                : SvgPicture.asset('assets/svg/figma_eye.svg'),
                                onPressed: (){
                                  signinVM.changePass2Visibility();

                                }
                            ),

                      ),
                      obscureText: signinVM.passwordVisible
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
                  UIHelper.getText("¿Ya tienes una contraseña?", 15.0, UIHelper.primaryBlueLight, FontWeight.bold)
                ],
              ),
              const SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.getText("Puedes ", 15.0, UIHelper.primaryBlueLight, FontWeight.bold),
                  InkWell(
                    child: UIHelper.getText("Ingresar con tu cuenta", 15.0, UIHelper.primaryBlueBold, FontWeight.bold),
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/login');
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
                      UIHelper.primaryOrange,
                      () { },
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