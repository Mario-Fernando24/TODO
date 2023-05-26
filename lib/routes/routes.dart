import 'package:flutter/cupertino.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/pages/auth/loading_page.dart';
import 'package:todo/pages/auth/login_page.dart';
import 'package:todo/pages/auth/register_page.dart';
import 'package:todo/pages/home/homePage.dart';

final Map<String, Widget Function(BuildContext)> appRoutes ={
   Constants.loadingPage       : ( _ ) => LoadingPage(),
   Constants.loginPage         : ( _ ) => LoginPage(),
   Constants.registerPage      : ( _ ) => RegisterPage(),
   Constants.homePage          : ( _ ) => HomePage()

};