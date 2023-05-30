import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context,snapshot) { 
          return Center(
            child: Text('Espere...')
          );
         },
        
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{

    final auth = Provider.of<AuthService>(context, listen: false);
    bool autenticado = await auth.isSignedIn();

    if(autenticado==true){
      Navigator.pushReplacementNamed(context, Constants.menuPage);
    }else{
      Navigator.pushReplacementNamed(context, Constants.loginPage);

    }

  }
}