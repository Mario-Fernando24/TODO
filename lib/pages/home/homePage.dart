import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/helpers/show_alert.dart';
import 'package:todo/helpers/show_toas_message.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/auth_services.dart';
import 'package:todo/services/task_services.dart';
import 'package:todo/widget/custom_date.dart';
import 'package:todo/widget/custom_form.dart';
import 'package:todo/widget/custom_input.dart';
import 'package:todo/widget/dropdownButton.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

@override
    void initState() {
      super.initState();
      final taskService = Provider.of<TaskService>(context, listen: false);  
      taskService.getInfoUser();
    }

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final taskService = Provider.of<TaskService>(context, listen: false);  

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(authService.getEmail(), style: TextStyle(color: Colors.black54),),
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
                  child: Text(authService.getUser()!.email!.substring(0,2) ?? ''),
              ),
            )
          ],
      ),

      body: Body(taskService: taskService),
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
        final String selectedOption = Constants.opciones;
        final List<String> options = [Constants.opciones,Constants.pendiente, Constants.completado];

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
                    selectedOption: selectedOption,
                    statusController: statusController,
                    option: options
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
                   if(titleController.text.length>0 && descriptionController.text.length>0 && statusController.text.length>0 && statusController.text!=Constants.opciones && dateController.text.length>0  ){
                     
                      final taskService = Provider.of<TaskService>(context, listen: false);
                      final authService = Provider.of<AuthService>(context, listen: false);

                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                      final Uuid uuid = Uuid();
                      final String uidAleato = uuid.v4();
                      Task task= Task(uid: uidAleato,uidUser:authService.getUser()!.uid, title: titleController.text, description: descriptionController.text, status:Constants.completado==statusController.text? true: false, time: dateController.text);
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

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.taskService,
  }) : super(key: key);

  final TaskService taskService;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
   
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: taskService.listenToCollection(authService.getUser()!.uid),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

          return Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {

          return Text('Error al cargar los datos');

          } else {

          final documentos = snapshot.data!.docs;
          final listaModelos = documentos.map((doc) => Task.fromJson(doc.data())).toList();

            return  ListView.builder(
            itemCount: listaModelos.length,
            itemBuilder: (BuildContext context, int index) {
              final modelo = listaModelos[index];
              return  ListUsuario(usuario: modelo);
             },
          );
       }
     },
   );
  }
}


class ListUsuario extends StatefulWidget {

  const ListUsuario({required this.usuario}) ;
  final Task usuario;

  @override
  State<ListUsuario> createState() => _ListUsuarioState();
}

class _ListUsuarioState extends State<ListUsuario> {

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context, listen: true);  
    
        return Container(
            margin: const EdgeInsets.only(left: 20,right: 30,bottom: 4,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/r5.png',
                          fit: BoxFit.cover,
                          width: 45,
                          height: 45,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: 
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(taskService.userModelo!.name! ?? '',
                                  //  overflow: TextOverflow.ellipsis, // Agrega puntos suspensivos (...) si el texto supera el límite
                                  //  maxLines: 1, // Limita el texto a una línea
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                              Text(taskService.userModelo!.email ?? '',style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.30),
                        child: GestureDetector(
                          child:  Icon(Icons.more_vert),
                          onTap: () {
                             optionMenu(context, widget.usuario);
                          },
                          )
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text('${widget.usuario.title!} ', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                const SizedBox(height: 8),
                Text(widget.usuario.description!, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      InkWell(
                        onTap: ()async {
                          await taskService.translateText(widget.usuario.description.toString());                          
                          showAlert(context, 'Translation',taskService.traductionn, 'ready');},
                        child: Text('Ver tradución',style: TextStyle(decoration: TextDecoration.underline,fontSize: 12, color: Colors.blue[200])),
                      ),
                     const VerticalDivider(),
                    Text('${widget.usuario.time}',style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
                     const VerticalDivider(),
                   widget.usuario.status==false
                    ? Icon(Icons.pending, size: 25, color: Colors.red[200],)
                    : Icon(Icons.assignment_turned_in_rounded, size: 25, color: Colors.blue[200],),
                  ],
                  
                ),
                
                const Divider()
              ],
            ),
        );
   }

    optionMenu(BuildContext context, Task task){

    final taskServicee = Provider.of<TaskService>(context, listen: false);  
    return   showCupertinoDialog(
      context: context, 
      builder: ( _ ){
         return CupertinoAlertDialog(
          title: Text('Menu de opciones'),
          content: Text('Si desea eliminar la tarea o marcarla como completado'),
          actions: [
            task.status==false?  CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Completar'),
              onPressed: ()async{
                Navigator.pop(context);
                await taskServicee.updateTaskStatus(widget.usuario.uid?? '');
                 // ignore: use_build_context_synchronously
                 showToasMessage(context, 'Tarea completada correctamente', Colors.blue);
              }
              ):Container(),
              CupertinoDialogAction(
                isDefaultAction: true,
              child: Text('Eliminar'),
              onPressed: () async{
                Navigator.pop(context);
                 taskServicee.removeTask(widget.usuario.uid?? '');
                 showToasMessage(context, 'Tarea eliminada correctamente', Colors.red);
              },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
              child: Text('Cancelar'),
              onPressed: ()=>Navigator.pop(context),
              )
          ],
         );
      }
    );
   }
}

