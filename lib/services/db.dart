import 'package:attendance_tracker/models/personModel.dart';
// import 'package:attendance_tracker/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference<Map<String, Object>> users = firestore.collection('users');

//After Reistration, create a profile in the users collection
Future<void> addPerson({PersonModel person, String uid}) async {
  var data = person.toJson();
  users
      .doc(uid)
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
  var isNew = true;

  if(person.dates == null){
    person.dates = [] as List<Date>;
  }
  for(int i=0;i<person.dates.length;i++){
    if(person.dates[i].date.day == date.day && person.dates[i].date.month == date.month && person.dates[i].date.year == date.year){
      isNew = false;
    }
  }

  if(isNew){
    person.dates.add(Date(date: date,status: true));
  } else {
    print("Already Set");
  }
   person.totalpresents += 1;

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

