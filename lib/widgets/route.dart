import 'package:attendance_tracker/Screens/adminHome.dart';
import 'package:attendance_tracker/Screens/staffHome.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:attendance_tracker/Screens/loginScreen.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationService>(context);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return LoginScreen(auth: auth);
          } else {
            return StreamBuilder<DocumentSnapshot<Map<String, Object>>>(
                stream: getPersonProfile(auth.currentUser.uid),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.active:
                      if(snapshot.hasData){
                          var staff = PersonModel.fromJson(snapshot.data.data());
                          if(staff.isAdmin){
                            return AdminHome( person : staff, auth: auth,);
                          }
                        return StaffHome(person : staff, auth: auth,);
                      } else {
                        return Scaffold(body: Center(child: CircularProgressIndicator()));
                      } break;
                    default :  
                      return Scaffold(body: Center(child: CircularProgressIndicator()));
                  }
                });
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
