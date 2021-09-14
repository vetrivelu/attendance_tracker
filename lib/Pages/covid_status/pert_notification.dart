// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tracer/constants/controller.dart';
// import 'package:tracer/db.dart';

// class PertNotification extends StatefulWidget {
//   const PertNotification({Key? key}) : super(key: key);

//   @override
//   _PertNotificationState createState() => _PertNotificationState();
// }

// class _PertNotificationState extends State<PertNotification> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'Covid Positive',
//             style: TextStyle(
//               color: Color(0xFF111443),
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//             textAlign: TextAlign.start,
//           ),
//           InkWell(
//             onTap: () {
//               pertController.yesButton.value = !pertController.yesButton.value;
//               pertController.noButton.value = false;
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       //width: 50.0,
//                       //height: 50.0,
//                       padding: const EdgeInsets.all(
//                           2.0), //I used some padding without fixed width and height
//                       decoration: new BoxDecoration(
//                         shape: BoxShape
//                             .circle, // You can use like this way or like the below line
//                         //borderRadius: new BorderRadius.circular(30.0),
//                         color: Colors.grey,
//                       ),
//                       child: CircleAvatar(
//                         // minRadius: 2.0,
//                         maxRadius: 3.0,
//                         backgroundColor: pertController.yesButton.value == true
//                             ? Color(0xFF111443)
//                             : Colors.white,
//                       ), // You can add a Icon instead of text also, like below.
//                       //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
//                     ),
//                     SizedBox(
//                       width: 3,
//                     ),
//                     Text(
//                       'Yes',
//                       style: TextStyle(color: Color(0xFF111443)),
//                     ),
//                   ],
//                 ),
//                 InkWell(
//                   onTap: () {
//                     pertController.noButton.value =
//                         !pertController.noButton.value;
//                     pertController.yesButton.value = false;
//                   },
//                   child: Row(
//                     children: [
//                       Container(
//                         //width: 50.0,
//                         //height: 50.0,
//                         padding: const EdgeInsets.all(
//                             2.0), //I used some padding without fixed width and height
//                         decoration: new BoxDecoration(
//                           shape: BoxShape
//                               .circle, // You can use like this way or like the below line
//                           //borderRadius: new BorderRadius.circular(30.0),
//                           color: Colors.grey,
//                         ),
//                         child: CircleAvatar(
//                           // minRadius: 2.0,
//                           maxRadius: 3.0,
//                           backgroundColor: pertController.noButton.value == true
//                               ? Color(0xFF111443)
//                               : Colors.white,
//                         ), // You can add a Icon instead of text also, like below.
//                         //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
//                       ),
//                       SizedBox(
//                         width: 3,
//                       ),
//                       Text(
//                         'No',
//                         style: TextStyle(
//                           color: Color(0xFF111443),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               employeeController.employee.covid!.testResult =
//                   pertController.noButton.value
//                       ? pertController.noButton.value
//                       : pertController.yesButton.value;
              
//               updateProfile();
//             },
//             child: Card(
//               color: Color(0xFF111443),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Send',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
