import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/Contact.dart';
import 'package:tracer/models.dart/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference<Map<String, dynamic>> users =
    firestore.collection('Employees');

Future<Employee> getProfile(String uid) async {
  // ignore: invalid_return_type_for_catch_error
  var docSnapshot =
      await users.doc(uid).get().catchError((onError) => print(onError.code));
  var data = docSnapshot.data();
  var employee = Employee.fromJson(data!);
  return employee;
}

createProfile(Employee employee) async {
  await users.add(employee.toJson()).then(
        (value) => users.doc(value.id).update(
          {'uid': value.id},
        ),
      );
}

updateProfile() async {
  var employee = employeeController.employee;
  // print('Profile Controller ${profileController.nameController.text}');
  // print(' Employee Name : ${employee.name}');
  // print('Employee Profile Name : ${employeeController.profile.first.name}');
  await users.doc(employee.uid).update(employee.toJson());
}

Future<Contact> userData(DocumentReference user) async {
  DocumentSnapshot userRef = await user.get();
  var data = userRef.data() as Map<String, dynamic>;
  return Contact.fromJson(data);
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getPersonProfile(String uid) {
  var documentStream = users.doc(uid).snapshots();
  return documentStream;
}
