import 'package:flutter/cupertino.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/pages/auth/loading_page.dart';
import 'package:todo/pages/auth/login_page.dart';
import 'package:todo/pages/auth/register_page.dart';
import 'package:todo/pages/home/homePage.dart';
import 'package:todo/pages/home/menu_page.dart';
import 'package:todo/pages/home/profile_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes ={
   Constants.menuPage          : ( _ ) =>  MenuPage(),
   Constants.loadingPage       : ( _ ) => LoadingPage(),
   Constants.loginPage         : ( _ ) => LoginPage(),
   Constants.registerPage      : ( _ ) => RegisterPage(),
   Constants.profilePage       : ( _ ) =>  ProfilePage(),
   Constants.homePage          : ( _ ) => HomePage()
};