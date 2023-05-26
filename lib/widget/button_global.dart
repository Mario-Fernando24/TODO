import 'package:flutter/material.dart';

class ButtonGlobal extends StatelessWidget {

  final String text;
  final void Function()? onPressed;

  const ButtonGlobal({super.key, required this.text, this.onPressed});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(265,46))),
      child: Text(text),
      onPressed: onPressed
      );
  }
}