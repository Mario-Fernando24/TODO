
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

  Stream<QuerySnapshot<Map<String, dynamic>>> listenToCollection(String idUser) {
  return FirebaseFirestore.instance
      .collection('Task')
       .where('uidUser', isEqualTo: idUser)
      .orderBy('status', descending: false)
      .orderBy('time', descending: true)
      .snapshots();
}

  Future<void> removeTask(String uid) async{

      await firestore.collection('Task').doc(uid).delete();

  }

  Future<void> updateTaskStatus(String uid) async{

    await firestore.collection('Task').doc(uid).update({'status': true});

  }

  
 
}