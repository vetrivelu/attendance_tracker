import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../db.dart';
// import 'package:provider/provider.dart';

class AuthenticationService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String _uid = '';

  set uid(text) => {_uid = text};

  String get uid => _uid;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;

  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((v) async {
        String? fcmtoken = await FirebaseMessaging.instance.getToken();
        print('FCM Token : $fcmtoken');
        if (fcmtoken != null) {
          users.doc(v.user!.uid).update({'fcm': fcmtoken});
        }
      });
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

  Future<void> logout() async {
    _firebaseAuth.signOut();
  }
}
