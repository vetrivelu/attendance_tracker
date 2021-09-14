import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracer/Pages/covid_status/status.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/employee.dart';

import '../../db.dart';

class QuarantineUpdate extends StatefulWidget {
  final Employee employee;
  const QuarantineUpdate({required this.employee, Key? key}) : super(key: key);

  @override
  _QuarantineUpdateState createState() => _QuarantineUpdateState();
}

class _QuarantineUpdateState extends State<QuarantineUpdate> {
  late TextEditingController address;
  late TextEditingController block;
  late TextEditingController startdate;
  late TextEditingController enddate;
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address = TextEditingController(text: widget.employee.quarantine!.address);
    block = TextEditingController(text: widget.employee.quarantine!.location);
    startdate = TextEditingController(
      text: DateFormat.yMMMd().format(widget.employee.quarantine!.from),
    );
    enddate = TextEditingController(
      text: DateFormat.yMMMd().format(widget.employee.quarantine!.to),
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.employee;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          // leading:
          centerTitle: true,
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 45,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'SAFE@CAMPUS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Color(0xffcd2122),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quarantine Location',
                  style: TextStyle(
                    color: Color(0xFF111443),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcd2122), width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcd2122), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: block,
                  decoration: InputDecoration(
                    labelText: 'Block No',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xffcd2122))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcd2122), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quarantine Date',
                  style: TextStyle(
                    color: Color(0xFF111443),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: startdate,
                  onTap: () {
                    _selectDate(context, startdate, true);
                  },
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: enddate,
                  onTap: () {
                    _selectDate(context, enddate, false);
                  },
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                     Color(0xffcd2122),
                    )),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Please wait Loading...'),
                            );
                          });
                      await users.doc(widget.employee.uid).update({
                        'quarantine': {
                          'address': address.text,
                          'location': block.text,
                          'from': from,
                          'to': to,
                        }
                      }).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('User Updated Successfully'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // setState(() {});
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Student Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ResultWidget(
                heading: 'Name',
                text: data.name,
              ),
              Divider(),
              ResultWidget(heading: 'ID', text: data.deviceId),
              Divider(),
              ResultWidget(
                heading: 'Group ID',
                text: data.groupId.toString(),
              ),
              Divider(),
              ResultWidget(
                heading: 'IC No',
                text: data.iCnumber,
              ),
              Divider(),
              ResultWidget(
                heading: 'Age',
                text: data.age.toString(),
              ),
              Divider(),
              ResultWidget(
                heading: 'Department',
                text: 'Department',
              ),
              Divider(),
              ResultWidget(
                heading: 'Phone No',
                text: data.phone!,
              ),
              Divider(),
              ResultWidget(
                heading: 'Address Lane 1',
                text: data.address1!,
              ),
              Divider(),
              ResultWidget(
                heading: 'Address Lane 2',
                text: data.address2!,
              ),
              Divider(),
              ResultWidget(
                heading: 'State',
                text: data.state!,
              ),
              Divider(),
              ResultWidget(
                heading: 'Postal/Zip Code',
                text: data.pinCode.toString(),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(
      BuildContext context, textEditingController, bool isStartdate) async {
    var _selectedDate;
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFFcd2122),
              ),
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      isStartdate ? from = newSelectedDate : to = newSelectedDate;
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
