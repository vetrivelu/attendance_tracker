import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';
import 'package:tracer/services/auth.dart';
import 'package:get/get.dart';

class AddCovidReport extends StatefulWidget {
  const AddCovidReport({Key? key}) : super(key: key);

  @override
  _AddCovidReportState createState() => _AddCovidReportState();
}

class _AddCovidReportState extends State<AddCovidReport> {
  String testmethod = 'swab';
  String typegroupValue = '';
  bool vaccinegroupValue = false;
  bool resultgroupValue = false;
  String employee = employeeController.employeelist.first.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                child: Icon(Icons.logout,color : Color(0xffcd2122).withOpacity(0.8),),
                onTap: () {
                  AuthenticationService().logout();
                }),
          ),
          title: Text('Add Report'),
          actions: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child:
              // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              // stream: users.snapshots(),
              // // builder: (context, snapshot) {
              //   if (!snapshot.hasData) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else {
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add New Student Covid Test',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(
                    'Student Name',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              onChanged: (String? v) {
                                setState(() {
                                  employee = v!;
                                });
                                print(employee);
                              },
                              value: employee,
                              items: employeeController.employeelist.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.uid.toString(),
                                  child: Text(e.name),
                                );
                              }).toList()
                              // [
                              //   DropdownMenuItem<String>(
                              //     value: 'swab',
                              //     child: Text('Swab Test'),
                              //   ),
                              //   DropdownMenuItem(
                              //     value: 'nasal',
                              //     child: Text('Nasal aspirate'),
                              //   ),
                              //   DropdownMenuItem(
                              //     value: 'rapid',
                              //     child: Text('Rapid Test'),
                              //   ),
                              // ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(
                    'Test Method',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            onChanged: (String? v) {
                              setState(() {
                                testmethod = v!;
                              });
                            },
                            value: testmethod,
                            items: [
                              DropdownMenuItem<String>(
                                value: 'swab',
                                child: Text('Swab Test'),
                              ),
                              DropdownMenuItem(
                                value: 'nasal',
                                child: Text('Nasal aspirate'),
                              ),
                              DropdownMenuItem(
                                value: 'rapid',
                                child: Text('Rapid Test'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(
                    'Test Type',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile<String>(
                    title: Text('Symptomatic'),
                    value: 'symptomatic',
                    activeColor: Color(0xFfcd2122),
                    groupValue: typegroupValue,
                    onChanged: (String? val) {
                      setState(() {
                        typegroupValue = val!;
                      });
                    }),
                RadioListTile<String>(
                    title: Text('Asymptomatic'),
                    value: 'asymptomatic',
                    activeColor: Color(0xFfcd2122),
                    groupValue: typegroupValue,
                    onChanged: (String? val) {
                      setState(() {
                        typegroupValue = val!;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(
                    'Vaccinated',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile<bool>(
                    title: Text('Yes'),
                    activeColor: Color(0xFfcd2122),
                    value: true,
                    groupValue: vaccinegroupValue,
                    onChanged: (val) {
                      setState(() {
                        vaccinegroupValue = val!;
                      });
                    }),
                RadioListTile<bool>(
                    title: Text('No'),
                    activeColor: Color(0xFfcd2122),
                    value: false,
                    groupValue: vaccinegroupValue,
                    onChanged: (val) {
                      setState(() {
                        vaccinegroupValue = val!;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(
                    'Test Result',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile<bool>(
                    title: Text('Positive'),
                    activeColor: Color(0xFfcd2122),
                    value: true,
                    groupValue: resultgroupValue,
                    onChanged: (val) {
                      setState(() {
                        resultgroupValue = val!;
                      });
                    }),
                RadioListTile<bool>(
                    title: Text('Negative'),
                    value: false,
                    activeColor: Color(0xFfcd2122),
                    groupValue: resultgroupValue,
                    onChanged: (val) {
                      setState(() {
                        resultgroupValue = val!;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print(employee); 
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Please wait Loading...'),
                            );
                          });
                      users.doc(employee).update({
                        'covid': {
                          'testMethod': testmethod,
                          'testResult': resultgroupValue,
                          'testType': typegroupValue,
                          'vaccinated': vaccinegroupValue,
                          'testDate': DateTime.now(),
                          'vaccinaionDate': DateTime.now()
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
                      'Send Report',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Color(0xFFcd2122),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
