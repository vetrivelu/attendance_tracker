import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/Pages/covid_status/pert_notification.dart';
import 'package:tracer/Pages/covid_status/status.dart';
import 'package:tracer/Pages/quarantine/pastquarantine.dart';
import 'package:tracer/Pages/quarantine/quarantine.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/employee.dart';

class QuarantineTab extends StatefulWidget {
  QuarantineTab({
    Key? key,
    // required this.quarantine,
  }) : super(key: key);
  // final Employee quarantine;
  @override
  _QuarantineTabState createState() => _QuarantineTabState();
}

class _QuarantineTabState extends State<QuarantineTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Quarantine History'),
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
                'assets/quarantinebanner.jpg',
              ),
            ),

            // Image.asset(
            //   'assets/quarantinebanner.jpg',
            //   fit: BoxFit.fitWidth,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Recent Quarantine',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'Address : ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: pastquarantine.first.address,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(
                                          0.75,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Block : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: pastquarantine.first.block,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(
                                          0.75,
                                        ),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF111343),
                              size: 30,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              pastquarantine.first.startdate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(
                                  0.75,
                                ),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              pastquarantine.first.enddate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(
                                  0.75,
                                ),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Duration : ${employeeController.profile[0].quarantine!.to.difference(employeeController.profile[0].quarantine!.from).inDays} Day(s)',
                              style: TextStyle(
                                  color: Colors.amber[100],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quarantine History',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastquarantine.length,
                itemBuilder: (context, index) {
                  QuarantineModel data = pastquarantine[index];
                  return Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RichText(
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
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RichText(
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
                  );
                })
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

  List pastquarantine = [
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
    QuarantineModel(
      address:
          'Lorong Perak, Pusat Bandar Melawati, Taman Melawati, Kuala Lumpur, 53100 03-4107-2066',
      block: 'A7',
      enddate: employeeController.profile[0].quarantine!.from
          .toString()
          .substring(0, 10),
      startdate: employeeController.profile[0].quarantine!.to
          .toString()
          .substring(0, 10),
    ),
  ];
}

class QuarantineModel {
  String startdate;
  String enddate;
  String address;
  String block;
  QuarantineModel(
      {required this.address,
      required this.block,
      required this.enddate,
      required this.startdate});
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
            labelColor: Color(0xFfcd2122).withOpacity(0.6),
            // activeColor: Color(0xFfcd2122),
            labelPadding: EdgeInsets.only(top: 10.0, right: 5.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Quarantine',
              ),
              //child: Image.asset('images/android.png'),

              Tab(
                text: 'Past Quarantine',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                QuarantinPage(),
                PastQuarantinPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
