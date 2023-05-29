import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToasMessage(BuildContext context, String title, Color color){
      Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
}