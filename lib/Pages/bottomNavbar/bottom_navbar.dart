import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tracer/Pages/History.dart';
import 'package:tracer/Pages/covid_status/covid_status.dart';
import 'package:tracer/Pages/home/home.dart';
import 'package:tracer/Pages/profile/profile.dart';
import 'package:tracer/Pages/quarantine/quarantinetab.dart';
import 'package:tracer/models.dart/employee.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.employee}) : super(key: key);
  final Employee employee;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabIndex = 0;
  late List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      EmployeeHomaPage(),
      History(),
      // CovidStatus(covid: widget.employee),
      QuarantineTab(),
      Profile(),
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
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF8DA0FF).withOpacity(0.53),
          backgroundColor: Color(0xFF111343),
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.system_update_alt),
              title: Text('Status'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              title: Text('Quarantine'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
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
