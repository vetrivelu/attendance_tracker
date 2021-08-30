import 'package:attendance_tracker/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

updatePerson(PersonModel person){
   users.doc(person.uid).update(person.toJson());
}

Stream<DocumentSnapshot<Map<String,Object>>> getPersonProfile(String uid) {
  Stream documentStream = users.doc(uid).snapshots();
  return documentStream;
}

Stream<QuerySnapshot<Map<String,Object>>> getPeople() {
  Stream collectionStream = users.snapshots();
  return collectionStream;
}



