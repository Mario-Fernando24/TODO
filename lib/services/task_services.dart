
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskService with ChangeNotifier{
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createTask(Task task) async{

        try {
          return firestore.collection('Task').doc().set(task.toJson());
        } catch (error) {
          print(error);
        }

  }
  
 
}