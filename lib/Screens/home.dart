import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/Encrypt.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:attendance_tracker/widgets/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    this.person,
  }) : super(key: key);
  final PersonModel person;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var firstDay = DateTime.utc(2021, 1, 1);
  var lastDay = DateTime.utc(2022, 1, 1);
  var _focusedDay = DateTime.now();

  // ignore: unused_field
  String _scanBarcode;

  getAttendanceonDate(DateTime date) {
    var status = 0;
    if (widget.person.dates.isNotEmpty) {
      widget.person.dates.forEach((element) {
        if (isSameDay(date, element.date)) {
          status = element.status;
        }
      });
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: [
            widget.person.isAdmin
                ? Container()
                : Card(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: Icon(
                                Icons.qr_code,
                                size: 100,
                              ),
                              onPressed: scanQR,
                            ),
                            Text("Scan to register your attendance")
                          ],
                        ),
                      ),
                    ),
                  ),
            GetDashboard(widget: widget),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text("Calendar"),
              leading: Icon(Icons.calendar_view_month),
              maintainState: true,
              initiallyExpanded: true,
              children: [
                TableCalendar(
                  firstDay: firstDay,
                  focusedDay: _focusedDay,
                  lastDay: lastDay,
                  onDaySelected: (selectedDay, focusedDay) {},
                  calendarBuilders: CalendarBuilders(
                      selectedBuilder: getSelectedBuilder,
                      defaultBuilder: getDefaultBuilder),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getDefaultBuilder(context, DateTime day, _) {
    if (day.weekday == DateTime.sunday)
      return NormalDay(
        day: day,
      );
    var status = getAttendanceonDate(day);
    print(status);
    return Container(
      height: 40,
      width: 40,
      child: Center(
        child: Text(day.day.toString()),
      ),
      decoration: (status == 2)
          ? BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )
          : (status == 3) ? (BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )) : null,
    );
  }

  Widget getSelectedBuilder(context, day, _) {
    return Container(
      height: 35,
      width: 35,
      child: Center(
        child: Text(day.day.toString()),
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (barcodeScanRes.isNotEmpty) {
        var decrypted = Encryptor.decrypt(barcodeScanRes);
        var date = DateTime.parse(decrypted);
        if (isSameDay(date, DateTime.now()))
          setAttendance(uid: widget.person.uid);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}

class GetDashboard extends StatelessWidget {
  const GetDashboard({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Home widget;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Dashboard"),
      leading: Icon(Icons.dashboard),
      // maintainState: true,
      children: [
        Dashboard(person: widget.person),
      ],
    );
  }
}

class NormalDay extends StatelessWidget {
  const NormalDay({
    Key key,
    this.day,
  }) : super(key: key);
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 43,
      child: Center(
        child: Text(
          day.day.toString(),
          style: TextStyle(color: Colors.red),
        ),
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.blue),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}
