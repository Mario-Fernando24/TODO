
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/helpers/preferencia.dart';

class AuthService with ChangeNotifier{
  
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user;
    bool _autenticando = false;
    String _respuesta = '';

    bool get autenticando => this._autenticando;
    String get respuesta => this._respuesta;

  get uid => null;

    set autenticando(bool valor){
      this._autenticando = valor;
      notifyListeners();
    }
    
    set respuesta(String valor){
      this._respuesta = valor;
      notifyListeners();
    }

    bool isSignedIn() {
        final currentUser = auth.currentUser;
        if (currentUser == null) {
          return false;
        }
        return true;
    }

    User? getUser() {
    return auth.currentUser;
    } 

      Future login(String email, String password) async {
          
        autenticando = true;

        try {
        
          UserCredential userCred = await auth.signInWithEmailAndPassword(
            email: email, password: password);
            autenticando = false;

        } on FirebaseAuthException catch (e) {
            autenticando = false;
          if (e.code == 'user-not-found') {
            _respuesta='No se encontró ningún usuario para ese correo electrónico.';
          }
         
          if (e.code == 'wrong-password') {
            _respuesta='Contraseña incorrecta.';
          }
        } catch (e) {
          _respuesta='Algo salió mal, inténtalo de nuevo.';
        }
        notifyListeners();
      }


    Future<void> createUser(String name ,String email, String password ) async {

            autenticando = true;

            try {

                await auth.createUserWithEmailAndPassword(email: email,password: password);
                final iduser = auth.currentUser!.uid;

                firestore.collection('Users').doc(iduser)
                .set({
                  'uid'     :iduser,
                  'name'    : name,
                  'email'   : email,
                  'password': password
                });

                 autenticando = false;

                if (user != null) { 
                  _respuesta='usuario registrado exitosamente';
                }
                } on FirebaseAuthException catch (e) {
                      autenticando = false;
                  if (e.code == 'weak-password') {
                    _respuesta='La contraseña es muy debil';
                  } else if (e.code == 'email-already-in-use') {
                    _respuesta='La cuenta ya  existe, por favor registrarse con otra cuenta';
                  } else if (e.code == 'invalid-email') {
                   _respuesta='Correo incorrecto';
                  }
              } catch (e) {
                 autenticando = false;
                print(' Problema de conexion ${e.toString()}');
              }
         notifyListeners();

  }

  Map<dynamic, dynamic> validateUsers(String name, String email, String password){

    var resp = {};

    if(name.isEmpty){
        resp = {'status':false,'sms': 'El nombre debe ser obligatorio'};
      return resp;
    }else if(email.isEmpty){
       resp = {'status': false,'sms': 'Debe ser un correo electronico valido'};
      return resp;
    }else if(password.length<6 || password.isEmpty){
       resp = {'status': false,'sms': 'Debe tener 6 caracteres o mas'};
      return resp;
    }else{
       resp = {'status': true, 'sms': 'Exitoso'};
      return resp;
    }

  }

  Future signOut() async {
    return Future.wait([auth.signOut()]);
  }

  
}