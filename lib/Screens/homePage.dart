
import 'package:attendance_tracker/Screens/home.dart';
import 'package:attendance_tracker/Screens/listview.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as crypt;
import 'package:attendance_tracker/services/Encrypt.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.auth});

  final AuthenticationService auth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final key = crypt.Key.fromUtf8('uqAaTfnfOCiI44kao92jLYQOPNJgDj');
  final iv = crypt.IV.fromLength(8);

  List<BottomNavigationBarItem> getBottomNavbarItems() {
    return [
      // BottomNavigationBarItem(icon:Icon(Icons.person), label: "My Report"),
      BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Code"),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "S.A.R."),
    ];
  }

  int _selectedIndex = 0;
  PersonModel person;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: getPersonProfile(widget.auth.currentUser.uid),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text("Error");
        }
        if(snapshot.connectionState == ConnectionState.active) {
          person = snapshot.data.exists ? PersonModel.fromJson(snapshot.data.data()) : null;
          return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.calendar_view_month),
            title: Text("Attendance app"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: Icon(Icons.logout),
                  onTap: widget.auth.logout,
                ),
              ),
            ],
            titleSpacing: 10,
          ),
          bottomNavigationBar: person.isAdmin
              ? BottomNavigationBar(
                  items: getBottomNavbarItems(),
                  currentIndex: _selectedIndex,
                  onTap: _setPage,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: getBody(context, _selectedIndex),
        );
        } else {
          return Text("Loading");
        }
      }
    );
  }
  Widget getBody(BuildContext context, _selectedIndex) {
    if(! person.isAdmin)
    _selectedIndex = null;
    switch (_selectedIndex) {
      case 0 : return Scaffold(
              body: Center(
                child: QrImage(
                  data: Encryptor.encrypt(DateTime.now().toString()),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            );
      case 1 : return ListPeople();
      default : return Home(person : person,);
    }
  }

  void _setPage(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  String encrypt(String plainText) {  
    final encrypter = crypt.Encrypter(Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print (encrypted.base64);
    return encrypted.base64;
  }

  String decrypt(String plainText) {
    // final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    final encrypter = crypt.Encrypter(Salsa20(key));

    final decrypted = encrypter.decrypt(crypt.Encrypted.from64(plainText), iv: iv);
    return decrypted;
  }
}


