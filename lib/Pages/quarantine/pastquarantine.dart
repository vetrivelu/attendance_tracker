import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/constants/controller.dart';

class PastQuarantinPage extends StatefulWidget {
  const PastQuarantinPage({Key? key}) : super(key: key);

  @override
  _PastQuarantineState createState() => _PastQuarantineState();
}

class _PastQuarantineState extends State<PastQuarantinPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
              height: 25.0,
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: double.infinity,
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '24/05/2021',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '10:45 PM',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xFF111443),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Past Detail',
                      style: TextStyle(
                        color: Color(0xFF111443),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
