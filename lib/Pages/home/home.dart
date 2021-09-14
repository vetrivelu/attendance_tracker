import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tracer/Pages/History.dart';
import 'package:tracer/Pages/covid_status/covid_status.dart';
import 'package:tracer/Pages/profile/profile.dart';
import 'package:tracer/Pages/quarantine/quarantinetab.dart';
import 'package:tracer/constants/controller.dart';
import 'package:shadow/shadow.dart';
import 'package:tracer/services/auth.dart';

import '../../main.dart';

class EmployeeHomaPage extends StatefulWidget {
  const EmployeeHomaPage({Key? key}) : super(key: key);

  @override
  _EmployeeHomaPageState createState() => _EmployeeHomaPageState();
}

class _EmployeeHomaPageState extends State<EmployeeHomaPage> {
  shownotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a Test Local Notification',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          playSound: true,
          color: Colors.indigo[900],
          icon: "@mipmap/ic_launcher",
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Test Notification'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This is a Test Local Notification'),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Ok'),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                playSound: true,
                color: Colors.indigo[900],
                icon: "@mipmap/ic_launcher",
              ),
            ));
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Ok'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;
      if (notification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                      Align(
                        heightFactor: 0.0,
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Ok'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () => shownotification(),
        //   label: Text('Send Notification'),
        // ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset('assets/logo.png'),
          ),
          title: Row(
            children: [
              // Text('SAFE@CAMPUS'),
              Spacer(),
              InkWell(
                  child: Text('Logout',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  onTap: () {
                    AuthenticationService().logout();
                  }),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage(
                'assets/maskdispose.jpg',
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "Don't forget to change your mask, ${employeeController.employee.name}.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Reminder :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                ' Hi ${employeeController.employee.name}, Your colleague Joe has exhibited symptoms of a possible COVID infection. As you have been in close contact, please return home, call +60-0-0000 0000 for a COVID test and begin self-isolation immediately. ',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => data[index].classname)),
                  child: Card(
                      color: data[index].color,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 25,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.37,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      data[index].text,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: data[index].textcolor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                    ),
                                  ),
                                ),
                              )),
                          Positioned(
                            right: 15,
                            bottom: 0,
                            // child: Shadow(
                            // offset: Offset(5, 0),
                            child: Image.asset(data[index].url,
                                height: 100, width: 100, fit: BoxFit.contain),
                          ),
                          // ),
                        ],
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  List data = [
    CardData(
        classname: History(),
        color: Colors.red.shade700,
        text: 'Contact History',
        url: 'assets/peoplemask.png',
        textcolor: Colors.red),
    CardData(
        classname: CovidStatus(),
        color: Color(0xFF111343),
        text: 'Covid Status',
        url: 'assets/status.png',
        textcolor: Color(0xFF222699)),
    CardData(
        classname: QuarantineTab(),
        color: Colors.amber.shade700,
        text: 'Quarantine History',
        url: 'assets/quarantine.png',
        textcolor: Colors.amber),
    CardData(
        classname: Profile(),
        color: Colors.teal.shade700,
        text: 'My Profile',
        url: 'assets/profile.png',
        textcolor: Colors.teal)
  ];
}

class CardData {
  var classname;
  Color textcolor;
  String text;
  String url;
  Color color;
  CardData(
      {required this.color,
      required this.text,
      required this.classname,
      required this.url,
      required this.textcolor});
}
