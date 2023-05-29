
import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/helpers/preferencia.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/auth_services.dart';

import '../models/users.dart';

class TaskService with ChangeNotifier{
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Task> _lisTask = [];
  StreamSubscription<DocumentSnapshot> ?_usersInfoSuscription;
  UserM ?userModelo;
  
  Future<void> cancelSubcription()async{
    _usersInfoSuscription!.cancel();
  }

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

  void  getInfoUser() async{

      DocumentSnapshot documentSnapshot = await firestore.collection('Users').doc(AuthService().getUser()!.uid).get();    
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
      userModelo = UserM.fromJson(data!);
      notifyListeners();

  }

 
}