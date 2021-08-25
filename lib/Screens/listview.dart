import 'package:attendance_tracker/Screens/PersonProfile.dart';
import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPeople extends StatelessWidget {
  const ListPeople({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: getPeople(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonProfile(person: PersonModel.fromJson(data),)),
                  );
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(data['name']),
                    subtitle: Text(
                        DateTime.parse(data['lastDate'].toDate().toString())
                            .toString()),
                    tileColor: Colors.indigo.shade200,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
