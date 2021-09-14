import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracer/Pages/Admin/quarantineupdate.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';
import 'package:tracer/models.dart/employee.dart';
import 'package:tracer/services/auth.dart';

class AdminCovidReport extends StatefulWidget {
  const AdminCovidReport({Key? key}) : super(key: key);

  @override
  _AdminCovidReportState createState() => _AdminCovidReportState();
}

class _AdminCovidReportState extends State<AdminCovidReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            users.get().then((snap) => snap.docs.forEach((element) {
                  users.doc(element.id).update(
                      {'contactHistory': [], 'covid.testResult': false});
                }));
          },
          child: Icon(Icons.refresh),
        ),
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
          title: Text('Covid Status'),
          actions: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:
                users.where('covid.testResult', isEqualTo: true).snapshots(),
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
                        return Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: 'Name : ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: employee.name.toString(),
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
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color(0xFF111443),
                                          ),
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QuarantineUpdate(
                                                    employee: employee),
                                          ),
                                        ),
                                        child: Text('Send to Quarantine'),
                                      ),
                                    ),
                                  ],
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
                                            : DateFormat.yMEd().format(
                                                employee.covid!.testDate!),
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
