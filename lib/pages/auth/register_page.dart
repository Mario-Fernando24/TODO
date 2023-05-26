import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/helpers/show_alert.dart';
import 'package:todo/widget/button_global.dart';
import 'package:todo/widget/custom_input.dart';
import 'package:todo/widget/logo.dart';
import '../../services/auth_services.dart';
import '../../widget/label.dart';
import '../../widget/terms_Conditions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                Logo(titulo: 'Registrarse'),
                _Form(),
                Labels(ruta: Constants.loginPage,titulo: 'Ya tienes cuenta?', subTitulo: 'Ingresa ahora!',),
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

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [

             CustomInput(
                icon: Icons.perm_identity, 
                placeHolder: 'Nombre',
                keyboardType: TextInputType.text,
                 textEditController: nameController
                ),

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
                  onPressed: authService.autenticando==true? null:()async{
                  FocusScope.of(context).unfocus();
                   var validate = authService.validateUsers(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());

                    if(validate['status']){
                      
                     await authService.createUser(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                     if(authService.isSignedIn()){
                      Navigator.pushReplacementNamed(context, Constants.homePage);
                     }else{
                        showAlert(context, 'Mensaje', authService.respuesta);
                     }

                    }else{
                        showAlert(context, 'Mensaje', validate['sms']);
                    }
                   }
                ) 
          ],
        ),
    );
   }
  }