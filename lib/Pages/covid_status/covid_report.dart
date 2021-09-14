import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';

class CovidReport extends StatefulWidget {
  const CovidReport({Key? key}) : super(key: key);

  @override
  _CovidReportState createState() => _CovidReportState();
}

class _CovidReportState extends State<CovidReport> {
  String testmethod = 'swab';
  String testresult = 'negative';
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //
            children: [
              Text(
                'Type',
                style: TextStyle(
                  color: Color(0xFF111443),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        employeeController.profile[0].covid?.testType =
                            'Symptomatic';
                      });
                      // pertController.yesButton.value =
                      //     !pertController.yesButton.value;
                      // pertController.noButton.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 16.0),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.grey,
                              child: Container(
                                //width: 50.0,
                                //height: 50.0,
                                padding: const EdgeInsets.all(
                                    2.0), //I used some padding without fixed width and height
                                decoration: new BoxDecoration(
                                  shape: BoxShape
                                      .circle, // You can use like this way or like the below line
                                  //borderRadius: new BorderRadius.circular(30.0),
                                  color: Colors.transparent,
                                ),
                                child: CircleAvatar(
                                  // minRadius: 2.0,
                                  maxRadius: 3.0,
                                  backgroundColor: employeeController
                                              .profile[0].covid?.testType ==
                                          'Symptomatic'
                                      ? Color(0xFF111443)
                                      : Colors.white,
                                ), // You can add a Icon instead of text also, like below.
                                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Symptomatic',
                            style: TextStyle(color: Color(0xFF111443)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        employeeController.profile[0].covid?.testType =
                            'Asymptomatic';
                      });
                      // pertController.noButton.value =
                      //     !pertController.noButton.value;
                      // pertController.yesButton.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: Container(
                              //width: 50.0,
                              //height: 50.0,
                              padding: const EdgeInsets.all(
                                  2.0), //I used some padding without fixed width and height
                              decoration: new BoxDecoration(
                                shape: BoxShape
                                    .circle, // You can use like this way or like the below line
                                //borderRadius: new BorderRadius.circular(30.0),
                                color: Colors.transparent,
                              ),
                              child: CircleAvatar(
                                // minRadius: 2.0,
                                maxRadius: 3.0,
                                backgroundColor: employeeController
                                            .profile[0].covid?.testType ==
                                        'Asymptomatic'
                                    ? Color(0xFF111443)
                                    : Colors.white,
                              ), // You can add a Icon instead of text also, like below.
                              //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Asymptomatic',
                            style: TextStyle(
                              color: Color(0xFF111443),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Covid Vaccine Recieved',
                style: TextStyle(
                  color: Color(0xFF111443),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              // -----------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        employeeController.profile[0].covid?.vaccinated = true;
                      });
                      // pertController.yesButton.value =
                      //     !pertController.yesButton.value;
                      // pertController.noButton.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 16.0),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.grey,
                              child: Container(
                                //width: 50.0,
                                //height: 50.0,
                                padding: const EdgeInsets.all(
                                    2.0), //I used some padding without fixed width and height
                                decoration: new BoxDecoration(
                                  shape: BoxShape
                                      .circle, // You can use like this way or like the below line
                                  //borderRadius: new BorderRadius.circular(30.0),
                                  color: Colors.transparent,
                                ),
                                child: CircleAvatar(
                                  // minRadius: 2.0,
                                  maxRadius: 3.0,
                                  backgroundColor: employeeController
                                          .profile[0].covid!.vaccinated!
                                      ? Color(0xFF111443)
                                      : Colors.white,
                                ), // You can add a Icon instead of text also, like below.
                                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(color: Color(0xFF111443)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        employeeController.profile[0].covid!.vaccinated = false;
                      });
                      // pertController.noButton.value =
                      //     !pertController.noButton.value;
                      // pertController.yesButton.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: Container(
                              //width: 50.0,
                              //height: 50.0,
                              padding: const EdgeInsets.all(
                                  2.0), //I used some padding without fixed width and height
                              decoration: new BoxDecoration(
                                shape: BoxShape
                                    .circle, // You can use like this way or like the below line
                                //borderRadius: new BorderRadius.circular(30.0),
                                color: Colors.transparent,
                              ),
                              child: CircleAvatar(
                                // minRadius: 2.0,
                                maxRadius: 3.0,
                                backgroundColor: !employeeController
                                        .profile[0].covid!.vaccinated!
                                    ? Color(0xFF111443)
                                    : Colors.white,
                              ), // You can add a Icon instead of text also, like below.
                              //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'No',
                            style: TextStyle(
                              color: Color(0xFF111443),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Test Method',
                style: TextStyle(
                  color: Color(0xFF111443),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
              SizedBox(
                height: 15,
              ),
              Text(
                'Test Result',
                style: TextStyle(
                  color: Color(0xFF111443),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
                            testresult = v!;
                          });
                        },
                        value: testresult,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'positive',
                            child: Text('Positive'),
                          ),
                          DropdownMenuItem(
                            value: 'negative',
                            child: Text('Negative'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // employeeController.employee.covid!.testResult =
                    //     pertController.noButton.value
                    //         ? pertController.noButton.value
                    //         : pertController.yesButton.value;

                    // updateProfile();
                  },
                  child: Card(
                    color: Color(0xFF111443),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
