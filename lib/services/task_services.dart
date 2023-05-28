
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskService with ChangeNotifier{
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createTask(Task task) async{

      try {

        firestore.collection('Task').doc(task.uidUser).set(task.toJson());
        
      } catch (e) {
        print(' Problema de conexion ${e.toString()}');
      }

  }
  
 
}