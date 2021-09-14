import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/constants/controller.dart';

class CovidStatus2 extends StatefulWidget {
  const CovidStatus2({Key? key}) : super(key: key);

  @override
  _CovidStatus2State createState() => _CovidStatus2State();
}

class _CovidStatus2State extends State<CovidStatus2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         
          SizedBox(
            height: 10,
          ),
         
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ResultWidget(
                  heading: 'Type',
                  text:
                      employeeController.profile[0].covid!.testType.toString(),
                ),
                ResultWidget(
                    heading: ' Vaccine ',
                    text: employeeController.profile[0].covid!.vaccinated!
                        ? "Yes"
                        : " No"),
                ResultWidget(
                    heading: ' Method',
                    text: employeeController.profile[0].covid!.testMethod
                        .toString()),
                ResultWidget(
                  heading: ' Result',
                  text: employeeController.profile[0].covid!.testResult!
                      ? "Positive"
                      : "Negative",
                ),
              ],
            ),
          ),
        ],
      ),
     
    );
  }
}

class ResultWidget extends StatelessWidget {
  final String heading;
  final String text;
  const ResultWidget({
    Key? key,
    required this.text,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              heading,
              style: TextStyle(
                color: Color(0xFF111443),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFF111443),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
