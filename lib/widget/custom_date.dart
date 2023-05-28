import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDate extends StatefulWidget {

  final IconData icon;
  final String placeHolder;
  final TextEditingController inputControllerFecha;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomDate({
        super.key, 
        required this.icon, 
        required this.placeHolder, 
        required this.inputControllerFecha, 
         this.keyboardType = TextInputType.text, 
         this.isPassword = false
      });

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
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
            enableInteractiveSelection: false,
            controller: widget.inputControllerFecha,
            decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Fecha',
            labelText: 'Fecha',
            icon:  Icon(widget.icon)
            ),
           onTap: () {
          //quitar el foco
          FocusScope.of(context).requestFocus(new FocusNode());
           _selectDate(context);
        }),
      );
    }

  _selectDate(BuildContext context) async {
    
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2023),
      lastDate: new DateTime(2099),
    );
    if (picked != null) {
      String _fecha = '';
      setState(() {
        int year = picked.year;
        int mth = picked.month;
        int day = picked.day;
        _fecha = '${day}/${mth}/${year}';
         widget.inputControllerFecha.text =_fecha;
      });
    }
  }
}