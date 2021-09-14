
import 'package:attendance_tracker/Screens/listview.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:attendance_tracker/services/Encrypt.dart';

class AdminHome extends StatefulWidget {
  AdminHome({this.person, this.auth});

  final PersonModel person;
  final AuthenticationService auth;
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
          // appBar: AppBar(
          //   leading: Icon(Icons.calendar_view_month),
          //   title: Text("Attendance app"),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 20),
          //       child: GestureDetector(
          //         child: Icon(Icons.logout),
          //         onTap: widget.auth.logout,
          //       ),
          //     ),
          //   ],
          //   titleSpacing: 10,
          // ),
          bottomNavigationBar: BottomNavigationBar(
                  items: getBottomNavbarItems(),
                  currentIndex: _selectedIndex,
                  onTap: _setPage,
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton(onPressed: widget.auth.logout, child: Icon(Icons.logout),),
          body: getBody(context, _selectedIndex),
        );
  }
  Widget getBody(BuildContext context, _selectedIndex) {
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
      default : return ListPeople();
    }
  }
  void _setPage(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}


