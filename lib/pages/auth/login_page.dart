import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/helpers/show_alert.dart';
import 'package:todo/services/auth_services.dart';
import 'package:todo/widget/button_global.dart';
import 'package:todo/widget/custom_input.dart';
import 'package:todo/widget/logo.dart';

import '../../widget/label.dart';
import '../../widget/terms_Conditions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Login'),
                _Form(),
                Labels(ruta: Constants.registerPage,titulo: '¿No tienes cuenta?', subTitulo: 'Crea una ahora!',),
                TermsConditions()
              ],
            ),
          ),
        ))
    );
  }

}

class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

   final emailController = TextEditingController();
    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context,);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [

              CustomInput(
                icon: Icons.email, 
                placeHolder: 'Correo electronico',
                keyboardType: TextInputType.emailAddress,
                 textEditController: emailController
                ),

                CustomInput(
                  icon: Icons.lock_outline, 
                  placeHolder: 'Contraseña',  
                  textEditController: passwordController,
                  isPassword: true,
                ),

                ButtonGlobal(
                  text: 'Ingresar',
                  onPressed: authService.autenticando==true? null:() async {
                      FocusScope.of(context).unfocus();
                      await authService.login(emailController.text.trim(), passwordController.text.trim());
                      if(authService.isSignedIn()){
                        Navigator.pushReplacementNamed(context, Constants.menuPage);
                      }else{
                      // ignore: use_build_context_synchronously
                      showAlert(context, 'Mensaje', authService.respuesta, 'Ok');

                      }
                  }
                  ) 
          ],
        ),
    );
   }
  }