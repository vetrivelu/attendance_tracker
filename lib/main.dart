import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tracer/controller/AuthController/authController.dart';
import 'package:tracer/controller/EmployeeController.dart/employeeControler.dart';
import 'package:tracer/controller/pertController/pert_controller.dart';
import 'package:tracer/landingPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'controller/loginController/login_controller.dart';
import 'controller/profileController/profile_controller.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'positive_push_notification',
    'Covid Alert!',
    'Your recent contact was just diagnosed with Covid Positive',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebasemessagingbghandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Notification Recieved : ${message.data}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebasemessagingbghandler(message));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(MyApp());
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(AuthController());
  Get.put(PertController());
  Get.put(EmployeeController());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
        // primarySwatch: Colors.,
      ),
      home: LandingPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);


//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(

//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var employee = await getProfile("qbseoEPU3TQYiyAXkYEFfNfvnFz2");
//           await employee.getEmployeeContacts();
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
