import 'package:flutter/material.dart';

class CustomDropDownButtom extends StatefulWidget {

  final IconData icon;
   String selectedOption;
  final List<String> option;
  final TextEditingController statusController;

   CustomDropDownButtom({
        super.key, 
        required this.icon, 
        required this.selectedOption, 
        required this.statusController, 
        required this.option,
      });

  @override
  State<CustomDropDownButtom> createState() => _CustomDropDownButtomState();
}

class _CustomDropDownButtomState extends State<CustomDropDownButtom> {
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

             child: DropdownButton<String>(
              value: widget.selectedOption,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(fontSize: 20, color: Colors.black54),
              underline: Container(),
              items: widget.option.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(option+'              '),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                 setState(() {
                  widget.statusController.text= value!;
                  widget.selectedOption= value!;
                });
              },
            ),
          );

      }
}