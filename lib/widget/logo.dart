import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  
  final String titulo;

  const Logo({super.key, required this.titulo});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
         child: Column(
          children: [
            const Image(image: AssetImage('assets/r5.png')),
            const SizedBox(height: 5,),
            Text(widget.titulo, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
          ],
         ),
      ),
    );
  }
}