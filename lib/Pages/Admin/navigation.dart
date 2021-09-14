import 'package:flutter/material.dart';
import 'package:tracer/Pages/Admin/covidstatus.dart';
import 'package:tracer/Pages/Admin/quarantinedetails.dart';

import 'addresport.dart';

class AdminNavigation extends StatefulWidget {
  @override
  _AdminNavigationState createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  int tabIndex = 0;
  late List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      AdminCovidReport(),
      QuarantineDetails(),
      AddCovidReport(),
      // AddEmployee(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> _widgetOptions = <Widget>[
    //   EmployeeHomaPage(),
    //   History(),
    //   // CovidStatus(covid: widget.employee),
    //   QuarantineTab(),
    //   Profile(),
    // ];
    return Scaffold(
      backgroundColor: Color(0xFF111343),
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor:  Color(0xffcd2122),
          unselectedItemColor: Color(0xffcd2122).withOpacity(0.6),
          backgroundColor: Colors.white,
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, ),
              title: Text('Covid Status', style: TextStyle(color: Color(0xffcd2122)),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              title: Text('Quarantine Update',style: TextStyle(color: Color(0xffcd2122)),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.system_update_alt),
              title: Text('Update Result',style: TextStyle(color: Color(0xffcd2122)),),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person_add),
            //   title: Text('Add Employee'),
            // ),
          ]),
    );
  }
}

class TopContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = 150.00;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, 0);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * 0.75, 0, width * 1.30, 0);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(
        width * 0.6, height * 1, width * 0, height * 0.7);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Color(0xFF111343);
    canvas.drawPath(ovalPath, paint);
    var path = Path();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
