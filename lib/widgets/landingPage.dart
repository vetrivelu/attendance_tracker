import 'package:attendance_tracker/Screens/homePage.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:attendance_tracker/Screens/loginScreen.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
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
            return FutureBuilder<PersonModel>(
                future: getPersonProfile(auth.currentUser.uid),
                builder: (context, snapshot) {
                    if(snapshot.hasData){
                      print(snapshot.data);
                      return MyHomePage(
                        auth: auth,
                        person: snapshot.data,
                      );
                    }
                    else return Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
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
