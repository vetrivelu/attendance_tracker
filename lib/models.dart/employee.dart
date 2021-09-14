// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';
import 'package:tracer/db.dart';
import 'package:get/get.dart';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    required this.age,
    required this.employeeId,
    required this.name,
    required this.uid,
    required this.isAdmin,
    this.state,
    this.address1,
    this.address2,
    this.contactHistory,
    this.covid,
    required this.deviceId,
    required this.groupId,
    required this.iCnumber,
    this.phone,
    required this.pinCode,
    this.quarantine,
  });

  int age;
  int employeeId;
  String name;
  String uid;
  bool isAdmin;
  String? state;
  String? address1;
  String? address2;
  List<ContactHistory>? contactHistory;
  Covid? covid;
  String deviceId;
  int groupId;
  String iCnumber;
  String? phone;
  int pinCode;
  Quarantine? quarantine;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      age: json["Age"],
      employeeId: json["EmployeeID"],
      name: json["Name"],
      uid: json["uid"],
      isAdmin: json["isAdmin"] ?? true,
      state: json["State"],
      address1: json["address1"],
      address2: json["address2"],
      contactHistory: (json["contactHistory"] != null)
          ? List<ContactHistory>.from(
              json["contactHistory"].map((x) => ContactHistory.fromJson(x)))
          : null,
      covid: (json["covid"] != null) ? Covid.fromJson(json["covid"]) : null,
      deviceId: json["deviceID"],
      groupId: json["groupID"],
      iCnumber: json["iCnumber"],
      phone: json["phone"],
      pinCode: json["pinCode"],
      quarantine: (json["quarantine"] != null)
          ? Quarantine.fromJson(json["quarantine"])
          : null);

  Map<String, dynamic> toJson() => {
        "Age": age,
        "EmployeeID": employeeId,
        "Name": name,
        "uid": uid,
        "isAdmin": isAdmin,
        "State": state,
        "address1": address1,
        "address2": address2,
        "contactHistory":
            List<dynamic>.from(contactHistory!.map((x) => x.toJson())),
        "covid": covid!.toJson(),
        "deviceID": deviceId,
        "groupID": groupId,
        "iCnumber": iCnumber,
        "phone": phone,
        "pinCode": pinCode,
        "quarantine": quarantine!.toJson(),
      };

  Future<List<Employee>> getEmployeeContacts() async {
    List<Employee> contacts = [];
    // this.contactHistory!.map((contact) async {
    //   var profile = await getProfile(contact.contact);
    //   contacts.add(profile);
    //   print(contact);
    // });

    this.contactHistory!.forEach((contact) async {
      var profile = await getProfile(contact.contact);
      contacts.add(profile);
      print(contact);
    });
    return contacts;
  }
}

class ContactHistory {
  ContactHistory({
    required this.contact,
    required this.time,
  });

  String contact;
  DateTime time;

  factory ContactHistory.fromJson(Map<String, dynamic>? json) => ContactHistory(
      contact: json!["contact"].toString(), time: json["time"].toDate());

  Map<String, dynamic> toJson() => {
        "contact": contact,
        "time": time,
      };
}

class Covid {
  Covid({
    this.testDate,
    this.testMethod,
    this.testResult,
    this.testType,
    this.vaccinaionDate,
    this.vaccinated,
  });

  DateTime? testDate;
  String? testMethod;
  bool? testResult;
  String? testType;
  DateTime? vaccinaionDate;
  bool? vaccinated;

  factory Covid.fromJson(Map<String, dynamic>? json) => Covid(
        testDate: json!["testDate"].toDate(),
        testMethod: json["testMethod"],
        testResult: json["testResult"],
        testType: json["testType"],
        vaccinaionDate: json["vaccinaionDate"].toDate(),
        vaccinated: json["vaccinated"],
      );

  Map<String, dynamic> toJson() => {
        "testDate": testDate,
        "testMethod": testMethod,
        "testResult": testResult,
        "testType": testType,
        "vaccinaionDate": vaccinaionDate,
        "vaccinated": vaccinated,
      };
}

class Quarantine {
  Quarantine({
    required this.from,
    required this.to,
    required this.location,
    required this.address,
  });

  DateTime from;
  DateTime to;
  String location;
  String address;

  factory Quarantine.fromJson(Map<String, dynamic> json) => Quarantine(
        from: json["from"].toDate(),
        to: json["to"].toDate(),
        location: json["location"],
        address: json["address"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "location": location,
      };
}
