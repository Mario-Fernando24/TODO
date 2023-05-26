import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/auth_services.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final usuario=[
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),
   Task(uidUser: 'Nombreuid',title: 'Un día eres Joven', description: 'Al otro dia pasas horas en excel tratando de encontrar donde esta el dato que no cuadra u arruino por completo múltiples decisiones de las ultimas semas', status: true, time: '13123123'),

  ];
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return  Scaffold(
      appBar: AppBar(
        title: Text(authService.getUser()!.email!, style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app,color: Colors.black54,),
          onPressed: ()async {
           await authService.signOut();
           Navigator.pushReplacementNamed(context, Constants.loginPage);
           }
          ),
          actions: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                  child: Text(authService.getUser()!.email!.substring(0,2)),
              ),
            )
          ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ( _ , i ) => Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                     CircleAvatar(
                      child: Text(usuario[i].title!.substring(0,2)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: 
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Mario Muñoz',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(width: 10),
                                  Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color:  Colors.blue[300],
                                    borderRadius: BorderRadius.circular(100)
                                  )
                                )
                              ],
                            ),
                            Text('@mariomunoz',style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                    )
                  ],
                ),
              ),

              Text(usuario[i].title!),
              
              Text(usuario[i].description!),
            ],
          ),
        ),
        separatorBuilder: ( _ , i ) => Divider(),
        itemCount: usuario.length,
      )
    );
  }
}