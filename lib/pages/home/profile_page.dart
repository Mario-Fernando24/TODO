import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/task_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final taskService = Provider.of<TaskService>(context, listen: false);  
    taskService.getInfoUser();

  }
 @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
        _backgruoundCover(context),
        _boxForm(context),
        _imageCover(context),
      ],
      ),
    );
  }

    Widget _backgruoundCover(BuildContext context){
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.4,
        color: Colors.blue,
      );
    }

    Widget _imageCover(BuildContext context){
      return  SafeArea(
        child: Container(
          margin: EdgeInsets.only(top:30 ),
          alignment: Alignment.topCenter,
            child: GestureDetector(
               child: const CircleAvatar(
                 backgroundImage:AssetImage('assets/r5.png'),
                 radius: 85,
                 backgroundColor: Colors.white,
                 ), 
            ),
            ),
      );
    }

    Widget _boxForm(BuildContext context){
              final taskService = Provider.of<TaskService>(context, listen: false);  

      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.34, left: 30, right: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 15,
              offset: Offset(0.0,75)
            )
          ]
        ),
        height: MediaQuery.of(context).size.height*0.30,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textUserName(taskService.userModelo!.name ?? ''),
              _textEmail(taskService.userModelo!.email ?? ''),
            ],
          ),
        ),
      );
    }

    Widget _textUserName(String name){
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Nombre"),
            subtitle: Text(name),
          ),
      );
    }

    Widget _textEmail(String email){
      return ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text(email),
        );
    }
}