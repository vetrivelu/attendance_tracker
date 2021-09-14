import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracer/Pages/Admin/quarantineupdate.dart';
import 'package:tracer/Pages/quarantine/quarantinetab.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';
import 'package:tracer/models.dart/employee.dart';
import 'package:tracer/services/auth.dart';

class QuarantineDetails extends StatefulWidget {
  const QuarantineDetails({Key? key}) : super(key: key);

  @override
  _QuarantineDetailsState createState() => _QuarantineDetailsState();
}

class _QuarantineDetailsState extends State<QuarantineDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                child: Text('Logout',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  AuthenticationService().logout();
                }),
          ),
          title: Text('Quarantine Status'),
          actions: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: users.where('quarantine', isNull: false).snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> da =
                            snapshot.data!.docs[index].data();
                        Employee? employee = Employee.fromJson(da);
                        QuarantineModel data = QuarantineModel(
                          address: employee.quarantine!.address,
                          block: employee.quarantine!.location,
                          startdate: DateFormat.yMEd()
                              .format(employee.quarantine!.from),
                          enddate:
                              DateFormat.yMEd().format(employee.quarantine!.to),
                        );
                        // itemCount: pastquarantine.length,
                        // itemBuilder: (context, index) {
                        //   QuarantineModel data = pastquarantine[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuarantineUpdate(
                                employee: employee,
                              ),
                            ),
                          ),
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  isThreeLine: true,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: 'Name : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo[900],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: employee.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Address : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo[900],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: data.address,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: 'Block : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo[900],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: data.block,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Duration : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo[900],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${employee.quarantine!.to.difference(employee.quarantine!.from).inDays} Day(s)',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color(0xFF111343),
                                        size: 19,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(data.startdate),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(data.enddate)
                                    ],
                                  ),
                                ),
                                // Divider(),
                              ],
                            ),
                          ),
                        );
                      });

              ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> da = snapshot.data!.docs[index].data();
                    Employee? employee = Employee.fromJson(da);
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'Device ID : ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: employee.employeeId.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.red.withOpacity(
                                          0.75,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Type',
                                    style: TextStyle(
                                        color: Color(0xFF111443),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    employee.covid?.testType ?? 'NA',
                                    style: TextStyle(
                                      color: Color(0xFF111443),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Covid Vaccination \nRecieved',
                                    style: TextStyle(
                                        color: Color(0xFF111443),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    employee.covid?.vaccinated == null
                                        ? 'NA'
                                        : employee.covid!.vaccinated!
                                            ? 'Yes'
                                            : 'No',
                                    style: TextStyle(
                                      color: Color(0xFF111443),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Test Method',
                                    style: TextStyle(
                                        color: Color(0xFF111443),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    employee.covid?.testMethod ?? 'NA',
                                    style: TextStyle(
                                      color: Color(0xFF111443),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Test Result',
                                    style: TextStyle(
                                        color: Color(0xFF111443),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    employee.covid?.testResult == null
                                        ? 'NA'
                                        : employee.covid!.testResult!
                                            ? 'Positive'
                                            : 'Negative',
                                    style: TextStyle(
                                      color: Color(0xFF111443),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Test Date',
                                    style: TextStyle(
                                        color: Color(0xFF111443),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    employee.covid?.testDate == null
                                        ? 'NA'
                                        : DateFormat.yMEd()
                                            .format(employee.covid!.testDate!),
                                    style: TextStyle(
                                      color: Color(0xFF111443),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // )
                      // : Center(
                      //     child: CircularProgressIndicator(),
                    );
                  });
            }),
      ),
    );
  }
}
