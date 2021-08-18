
import 'package:attendance_tracker/Screens/home.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.auth, this.person});

  final AuthenticationService auth;
  final PersonModel person;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<BottomNavigationBarItem> getBottomNavbarItems() {
    return [
      // BottomNavigationBarItem(icon:Icon(Icons.person), label: "My Report"),
      BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Code"),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "S.A.R."),
    ];
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

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
      bottomNavigationBar: widget.person.isAdmin
          ? BottomNavigationBar(
              items: getBottomNavbarItems(),
              currentIndex: _selectedIndex,
              onTap: _setPage,
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: getBody(context, _selectedIndex)
    );
  }
  Widget getBody(BuildContext context, _selectedIndex) {
    if(! widget.person.isAdmin)
    _selectedIndex = null;
    switch (_selectedIndex) {
      case 0 : return Scaffold(
              body: Center(
                child: QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            );
      case 1 : return Scaffold(body: Container(color: Colors.green,),);
      default : return Home();
    }
  }

  void _setPage(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}


