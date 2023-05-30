import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle, String button){

    if(!Platform.isAndroid){

      showDialog(
        context: context,
        builder: ( _ ) => AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              child: Text(button),
              elevation: 5,
              textColor: Colors.blue,
              onPressed:()=>Navigator.pop(context)
            )
          ],
        )
      );
   }else{
        showCupertinoDialog(
          context: context, 
          builder: ( _ ){
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                  child: Text(button, style: TextStyle(color: Colors.blue),),
                  onPressed: ()=>Navigator.pop(context),
                  )
              ],
            );
          }
        );

   }

}