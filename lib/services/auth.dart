
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class AuthenticationService extends ChangeNotifier 
{
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges(); 
  User get currentUser => _firebaseAuth.currentUser;


  Future<String> signUpwithEmailandPassword({ String email,  String password,  String name}) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // notifyListeners();
      print(credential.user.uid);
      addPerson(person : PersonModel(name: name, lastDate: DateTime.now()), uid : credential.user.uid);
      return credential.user.uid;
    } on FirebaseAuthException catch (e) {
      return "error" + e.code;
    }
    
  }

  Future<String> signInWithEmailAndPassword({ String email,  String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.uid);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') { 
        print('No user found for that email.');
        return "error" + e.code;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "error" + e.code;
      }
    }
    return "error Unknown";
  }

  Future<void> logout()
  async {
    _firebaseAuth.signOut();
  }
}
