import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/constants/controller.dart';

class QuarantinPage extends StatefulWidget {
  const QuarantinPage({Key? key}) : super(key: key);

  @override
  _QuarantineState createState() => _QuarantineState();
}

class _QuarantineState extends State<QuarantinPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Quarantine Location',
              style: TextStyle(
                color: Color(0xFF111443),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              elevation: 5.0,
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: Color(0xFF111443),
                      size: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'Address',
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Block',
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          employeeController.profile[0].quarantine!.location,
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'A',
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Quarantine Period',
              style: TextStyle(
                color: Color(0xFF111443),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              elevation: 5.0,
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Color(0xFF111443),
                      size: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'Start Date',
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'End Date',
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          employeeController.profile[0].quarantine!.from
                              .toString()
                              .substring(0, 10),
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          employeeController.profile[0].quarantine!.to
                              .toString()
                              .substring(0, 10),
                          style: TextStyle(
                            color: Color(0xFF111443),
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
