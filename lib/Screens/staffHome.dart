import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/Encrypt.dart';
import 'package:attendance_tracker/services/auth.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:attendance_tracker/widgets/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({
    this.person,
    this.auth,
    this.isAdminView = false,
  });
  final PersonModel person;
  final AuthenticationService auth;
  final bool isAdminView;
  @override
  _StaffHomeState createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  var firstDay = DateTime.utc(2021, 1, 1);
  var lastDay = DateTime.utc(2022, 1, 1);
  var _focusedDay = DateTime.now();
  var calendarStatus;
  @override
  void initState() {
    super.initState();
    calendarStatus = widget.person.getCalendarAttendance(DateTime.now().month);
  }

  // ignore: unused_field
  String _scanBarcode;
  String returnMessage;

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
    return Scaffold(
      floatingActionButton: widget.isAdminView ? null : FloatingActionButton(
        onPressed:(){
          if((widget.isAdminView)){
            Navigator.pop(context);
          }else {
            widget.auth.logout();
          }
        },
        child: widget.isAdminView ? Icon(Icons.flip_to_back) : Icon(Icons.logout),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocatio,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                widget.isAdminView
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
                                      isSameDay(DateTime.now(),
                                              widget.person.lastDate)
                                          ? Icons.done
                                          : Icons.qr_code,
                                      size: 100,
                                    ),
                                    onPressed: isSameDay(DateTime.now(),
                                            widget.person.lastDate)
                                        ? () {}
                                        : scanQR),
                                Text(isSameDay(
                                        DateTime.now(), widget.person.lastDate)
                                    ? "Attendance Registerd"
                                    : "Scan to register your attendance")
                              ],
                            ),
                          ),
                        ),
                      ),
                ExpansionTile(
                  title: Text("Dashboard"),
                  initiallyExpanded: widget.isAdminView,
                  leading: Icon(Icons.dashboard),
                  // maintainState: true,
                  children: [
                    Dashboard(person: widget.person),
                  ],
                ),
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
                      onDaySelected: (selectedDay, focusedDay) {
                        var status = getAttendanceonDate(selectedDay);
                        if (status == 0)
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Alert Dialog Box"),
                              content: Text(
                                  "Apply leave on ${selectedDay.year}-${selectedDay.month}-${selectedDay.day} ?"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.person.setLeave(selectedDay);
                                    updatePerson(widget.person);
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("okay"),
                                ),
                              ],
                            ),
                          );
                      },
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: getSelectedBuilder,
                        defaultBuilder: getDefaultBuilder,
                        todayBuilder: getDefaultBuilder,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDefaultBuilder(context, DateTime day, _) {
    var color;
    var status = 0;
    if (day.weekday == DateTime.sunday)
      return NormalDay(
        day: day,
      );
    if (calendarStatus != null) {
      status = calendarStatus[day.day];
    } else
      status = getAttendanceonDate(day);

    print(status);
    switch (status) {
      case 1:
        color = Colors.greenAccent;
        break;
      case 2:
        color = Colors.indigoAccent;
        break;
      case 3:
        color = Colors.yellowAccent;
        break;
      case 4:
        color = Colors.orangeAccent;
        break;
      default:
        if (day.isAfter(DateTime.now()))
          color = Colors.white10;
        else
          color = Colors.redAccent;
    }
    return Container(
        height: 40,
        width: 40,
        child: Center(
          child: Text(day.day.toString()),
        ),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ));
  }

  Widget getSelectedBuilder(context, day, _) {
    return Container(
      height: 35,
      width: 35,
      color: Colors.grey,
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
      print(barcodeScanRes);
      if (barcodeScanRes.isNotEmpty) {
        var decrypted = Encryptor.decrypt(barcodeScanRes);
        var date = DateTime.parse(decrypted);

        if (isSameDay(date, DateTime.now()))
          // ignore: await_only_futures
          returnMessage = await widget.person.setAttendance();
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
