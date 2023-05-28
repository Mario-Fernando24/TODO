import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/helpers/show_toas_message.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/auth_services.dart';
import 'package:todo/services/task_services.dart';
import 'package:todo/widget/custom_date.dart';
import 'package:todo/widget/custom_form.dart';
import 'package:todo/widget/custom_input.dart';
import 'package:todo/widget/dropdownButton.dart';

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
                      radius: 17,
                  child: Text(authService.getUser()!.email!.substring(0,2)),
              ),
            )
          ],
      ),
      body: _ListTask(usuario: usuario),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40,),
        onPressed: ()=>addNewTask(),
        elevation: 1,
      ),
    );
  }


  addNewTask(){

        final titleController = new TextEditingController();
        final descriptionController = new TextEditingController();
        final statusController = new TextEditingController();
        final dateController = new TextEditingController();
        final String _selectedOption = Constants.pendiente;
        final List<String> _options = [Constants.pendiente, Constants.completado];

        return  showDialog(
          context: context, 
          builder: (context){
            return AlertDialog(
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              title: Text('Nueva tarea', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                  CustomInput(
                    icon: Icons.title_outlined, 
                    placeHolder: 'Titulo',  
                    textEditController: titleController,
                    keyboardType: TextInputType.text
                  ),

                  CustomForm(textEditController: descriptionController), 

                  CustomDropDownButtom(
                    icon: Icons.title_outlined,
                    selectedOption: _selectedOption,
                    statusController: statusController,
                    option: _options
                  ),
                     
                  CustomDate(
                    icon: Icons.date_range_outlined,
                    placeHolder: '',
                    inputControllerFecha: dateController
                    )
                   
                  ],
                ),
              ),
              actions: [

                ElevatedButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[300],
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),

                ElevatedButton(
                child: Text('Publicar'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[300],
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                   onPressed: () async{
                   if(titleController.text.length>0 && descriptionController.text.length>0 && statusController.text.length>0 && dateController.text.length>0 ){
                     
                      final taskService = Provider.of<TaskService>(context, listen: false);
                      final authService = Provider.of<AuthService>(context, listen: false);

                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                      Task task= Task(uidUser:authService.getUser()!.uid, title: titleController.text, description: descriptionController.text, status:Constants.completado==statusController.text? true: false, time: dateController.text);
                      await  taskService.createTask(task);
                      showToasMessage(context, 'Tarea agregada correctamente', Colors.blue);

                    }else{
  
                      showToasMessage(context, 'Todos los campos son obligatorios', Colors.black);
                    }

                    
                  },
                ),
              ],
            );
          },  
        );
   }




}

class _ListTask extends StatelessWidget {
  const _ListTask({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final List<Task> usuario;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _ , i ) => Container(
        margin: const EdgeInsets.only(left: 20,right: 30,bottom: 4,top: 5),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 5),
            Text('${usuario[i].title!} ', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
            SizedBox(height: 8),
            Text(usuario[i].description!, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
          ],
        ),
      ),
      separatorBuilder: ( _ , i ) => Divider(),
      itemCount: usuario.length,
    );
  }
}