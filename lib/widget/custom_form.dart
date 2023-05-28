import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {

  final TextEditingController textEditController;

  const CustomForm({
        super.key, 
        required this.textEditController, 
      });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
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
             child:TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 180,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                      labelText: 'Descripción',
                    ),
                    
                  onChanged: (valor) {
                      setState(() {
                       widget.textEditController.text =valor;
                      });
                    },
                  ),
           );

      }
}