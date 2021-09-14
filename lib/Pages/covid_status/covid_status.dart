import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/Pages/covid_status/covid_report.dart';
import 'package:tracer/Pages/covid_status/pert_notification.dart';
import 'package:tracer/Pages/covid_status/status.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/employee.dart';

import '../../db.dart';

class CovidStatus extends StatefulWidget {
  CovidStatus({
    Key? key,
    // required this.covid,
  }) : super(key: key);
  // final Employee covid;
  @override
  _CovidStatusState createState() => _CovidStatusState();
}

class _CovidStatusState extends State<CovidStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Covid Status'),
          actions: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        body: ListView(
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage(
                'assets/statusbanner.jpg',
              ),
            ),
            // Image.asset(
            //   'assets/statusbanner.jpg',
            //   fit: BoxFit.fitWidth,
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                // height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.amber[600],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Type : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white.withOpacity(
                                    0.9,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: employeeController
                                        .profile[0].covid!.testType
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white.withOpacity(
                                        0.9,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            RichText(
                              text: TextSpan(
                                text: 'Test Method : ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white.withOpacity(
                                    0.85,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: employeeController
                                        .profile[0].covid!.testMethod
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white.withOpacity(
                                        0.9,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              employeeController.profile[0].covid!.vaccinated!
                                  ? "Vaccinated"
                                  : " Not Vaccinated",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withOpacity(
                                  0.85,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        employeeController.profile[0].covid!.testResult!
                            ? 'Positive'
                            : 'Negative',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color:
                              employeeController.profile[0].covid!.testResult!
                                  ? Colors.red.withOpacity(0.85)
                                  : Colors.green.withOpacity(
                                      0.85,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Report Your Test Now!',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
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
                groupValue: typegroupValue,
                onChanged: (String? val) {
                  setState(() {
                    typegroupValue = val!;
                  });
                }),
            RadioListTile<String>(
                title: Text('Asymptomatic'),
                value: 'asymptomatic',
                groupValue: typegroupValue,
                onChanged: (String? val) {
                  setState(() {
                    typegroupValue = val!;
                  });
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
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
                value: true,
                groupValue: vaccinegroupValue,
                onChanged: (val) {
                  setState(() {
                    vaccinegroupValue = val!;
                  });
                }),
            RadioListTile<bool>(
                title: Text('No'),
                value: false,
                groupValue: vaccinegroupValue,
                onChanged: (val) {
                  setState(() {
                    vaccinegroupValue = val!;
                  });
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
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
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Please wait Loading...'),
                        );
                      });
                  users.doc(employeeController.employee.uid).update({
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
                    backgroundColor: MaterialStateProperty.all(Colors.amber)),
              ),
            ),
          ],
        ),
        // body: Stack(
        //   children: [
        //     // Container(
        //     //   height: Get.height * 0.25,
        //     //   color: Color(0xFF111443),
        //     // ),
        //     Column(
        //       children: [
        //         SizedBox(
        //           height: Get.height * 0.74,
        //           child: Center(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10.0),
        //               child: Card(
        //                 elevation: 20,
        //                 child: TabBarViewWidget(),
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.all(
        //                     Radius.circular(8.0),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }

  String testmethod = 'swab';
  String typegroupValue = '';
  bool vaccinegroupValue = false;
  bool resultgroupValue = false;
}

class TabBarViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            indicatorWeight: 5.0,
            labelColor: Color(0xFF111443),
            labelPadding: EdgeInsets.only(top: 10.0, right: 5.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Covid Status',
              ),
              //child: Image.asset('images/android.png'),

              Tab(
                text: 'Covid Report',
              ),
              // Tab(
              //   text: 'Pert Notification',
              // ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CovidStatus2(),
                CovidReport(),
                // PertNotification(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
