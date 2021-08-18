import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var firstDay = DateTime.utc(2021, 1, 1);
  var lastDay = DateTime.utc(2022, 1, 1);
  var _focusedDay = DateTime.now();
  var _selectedDay = DateTime.now();

  String _scanBarcode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: [
            Card(
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
                        size: 100,),
                      onPressed: (){},
                    ),
                     Text("Touch to Scan")
                  ],),
                ),
              ),
            ),
            ExpansionTile(
              title: Text("Dashboard"),
              leading: Icon(Icons.dashboard),
              // maintainState: true,
              children: [
                Dashboard(person: PersonModel(name: "Vetri", isAdmin: false))
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
                  selectedDayPredicate: ((day) {
                    return isSameDay(_selectedDay, day);
                  }),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                )
              ],
            ),
          ],
        ),
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
