
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskService with ChangeNotifier{
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Task> _lisTask = [];




  Future<void> createTask(Task task) async{
        try {
          return firestore.collection('Task').doc(task.uid).set(task.toJson());
        } catch (error) {
          print(error);
        }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> listenToCollection() {
     return firestore.collection('Task').snapshots();
  }

  Future<void> removeTask(String uid) async{

      await firestore.collection('Task').doc(uid).delete();

  }

  Future<void> updateTaskStatus(String uid) async{

    await firestore.collection('Task').doc(uid).update({'status': true});

  }

  
 
}