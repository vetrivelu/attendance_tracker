import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracer/Pages/Admin/navigation.dart';
import 'package:tracer/Pages/bottomNavbar/bottom_navbar.dart';
import 'package:tracer/Pages/home/home.dart';
import 'package:tracer/Pages/loginPage.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';
import 'package:tracer/models.dart/employee.dart';
import 'package:tracer/services/auth.dart';

class LandingPage extends StatelessWidget {
  final auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return LoginPage(
                auth: auth,
              );
            } else {
              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream:
                      getPersonProfile(authController.auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          DocumentSnapshot<Map<String, dynamic>> document =
                              snapshot.data!;
                          var model = Employee.fromJson(document.data()!);
                          print(model.isAdmin);
                          employeeController.employee = model;
                          employeeController.profile.value = [model];
                          return model.isAdmin
                              ? AdminNavigation()
                              : EmployeeHomaPage();
                          // : Home(employee: employeeController.employee);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      default:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
      ),
    );
  }
}
