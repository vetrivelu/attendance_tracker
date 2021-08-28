import 'package:attendance_tracker/models/personModel.dart';
// import 'package:attendance_tracker/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference<Map<String, Object>> users = firestore.collection('users');

//After Reistration, create a profile in the users collection
Future<void> addPerson({PersonModel person, String uid}) async {
  var data = person.toJson();
  users
      .doc(person.uid)
      .set(data)
      .then((value) => print("Value added"))
      .catchError((error) => print("Error"));
  print("Person Added");
}

//set Attendeance

Future<void> setAttendance({String uid}) async {

  var date = DateTime.now().toUtc();
  var doc = await users.doc(uid).get();
  var person = PersonModel.fromJson(doc.data());

  if(person.dates == null){
    person.dates = [];
  }
 

  if(isSameDay(person.lastDate, date))
  {
    print("Date Already Set");
  } else {
    if(date.hour <= 10 && date.minute <15){
      person.dates.add(Date(date: date,status: 1)); // Present
      users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totalpresents" : FieldValue.increment(1)});
      person.totalpresents += 1;
    } else if (date.hour <= 1 && date.minute <= 0) {
      person.dates.add(Date(date: date,status: 3)); // half-day
      users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totalhalfDays" : FieldValue.increment(1)});
      person.totalhalfDays += 1;
    } else {
      person.dates.add(Date(date: date,status: 2)); //  late
      users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totallates" : FieldValue.increment(1)});
      person.totallates += 1;
    }
  }
  users.doc(uid).update(person.toJson());
}

Stream<DocumentSnapshot<Map<String,Object>>> getPersonProfile(String uid) {
  Stream documentStream = users.doc(uid).snapshots();
  return documentStream;
}

Stream<QuerySnapshot<Map<String,Object>>> getPeople() {
  Stream collectionStream = users.snapshots();
  return collectionStream;
}



