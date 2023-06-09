import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeHolder;
  final TextEditingController textEditController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
        super.key, 
        required this.icon, 
        required this.placeHolder, 
        required this.textEditController, 
         this.keyboardType = TextInputType.text, 
         this.isPassword = false
      });


      @override
      Widget build(BuildContext context) {

        return Container(
            padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0,5),
                    blurRadius: 5
                  )
              ]
            ),
             child: TextField(
              autocorrect: false,
              controller: textEditController,
              keyboardType: keyboardType,
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeHolder
              ),
            )
          );

      }
  

}