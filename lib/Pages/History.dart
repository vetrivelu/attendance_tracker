// import 'package:flutter/material.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:tracer/db.dart';
// import 'package:tracer/constants/controller.dart';

// class History extends StatefulWidget {
//   History({Key? key}) : super(key: key);
//   final Graph graph = Graph()..isTree = true;
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

//   @override
//   _HistoryState createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {
//   @override
//   void initState() {
//     super.initState();
//     List<Node> nodes = [];
//     int i = 0;
//     var contactList = employeeController.profile[0].contactHistory!.toList();
//     var employees = [];
//     nodes.add(Node(createNode(employeeController.employee.name)));

//     contactList.forEach((element) async {
//       employees.add(await getProfile(element.contact));
//       nodes.add(Node(createNode(element.contact)));
//       widget.graph.addEdge(nodes[0], nodes[++i]);
//       print(widget.graph.edges.length);
//       widget.builder
//         ..siblingSeparation = (100)
//         ..levelSeparation = (150)
//         ..subtreeSeparation = (150)
//         ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: InteractiveViewer(
//           child: GraphView(
//             graph: widget.graph,
//             algorithm: BuchheimWalkerAlgorithm(
//               widget.builder,
//               TreeEdgeRenderer(widget.builder),
//             ),
//             builder: (Node node) {
//               return createNode(node.key!.value);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget createNode(String nodeText) {
//     return Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           // borderRadius: BorderRadius.circular(4),
//           color: Colors.black,
//           boxShadow: [
//             BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
//           ],
//         ),
//         child: Text(nodeText));
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracer/db.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/employee.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<ContactHistory> positivecontactlist = [];

  @override
  void initState() {
    super.initState();
    gethistory();
  }

  gethistory() {
    var contactList = employeeController.profile[0].contactHistory!.toList();
    contactList.forEach((element) async {
      await users.doc(element.contact).get().then((value) {
        if (value.get('covid')['testResult'] == true) {
          setState(() {
            positivecontactlist.add(
              ContactHistory(
                  employee: Employee.fromJson(value.data()!),
                  time: element.time),
            );
          });

          print(value.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Contact History'),
          actions: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: positivecontactlist.length,
          itemBuilder: (context, index) {
            var data = positivecontactlist[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Group ID : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: data.employee.groupId.toString(),
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
                          // SizedBox(
                          // height: 15.0,
                          // ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Device ID : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: data.employee.deviceId.toString(),
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
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: 'Time Stamp : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: DateFormat.yMEd()
                                    .add_jm()
                                    .format(data.time),
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContactHistory {
  Employee employee;
  DateTime time;
  ContactHistory({required this.employee, required this.time});
}
