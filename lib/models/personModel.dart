// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';
import 'package:attendance_tracker/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

PersonModel personModelFromJson(String str) =>
    PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel with ChangeNotifier {
  PersonModel({
    this.name,
    this.phone,
    this.isAdmin = false,
    this.totalpresents = 0,
    this.totallates = 0,
    this.totalhalfDays = 0,
    this.totalLeaves = 0,
    this.totalHolidays = 0,
    this.totalUnassigned = 0,
    this.dates,
    this.lastDate,
    this.uid,
    // this.march,
    // this.april,
    // this.may,
    // this.june,
    // this.july,
    // this.august,
    // this.september,
    // this.october,
    // this.november,
    // this.december,
  });

  String name;
  String phone;
  bool isAdmin;
  int totalpresents;
  int totallates;
  int totalhalfDays;
  int totalLeaves;
  int totalHolidays;
  int totalUnassigned;
  List<Date> dates;
  DateTime lastDate;
  String uid;
  // List<Month> february;
  // List<Month> march;
  // List<Month> april;
  // List<Month> may;
  // List<Month> june;
  // List<Month> july;
  // List<Month> august;
  // List<Month> september;
  // List<Month> october;
  // List<Month> november;
  // List<Month> december;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        name: json["name"],
        phone: json["phone"],
        isAdmin: json["isAdmin"],
        totalpresents: json["totalpresents"],
        totallates: json["totallates"],
        totalhalfDays: json["totalhalfDays"],
        totalLeaves: json["totalLeaves"],
        totalHolidays: json["totalHolidays"],
        totalUnassigned: json["totalUnassigned"],
        dates: json["dates"] != null
            ? List<Date>.from(json["dates"].map((x) => Date.fromJson(x)))
            : null,
        lastDate: DateTime.parse(json["lastDate"].toDate().toString()),
        uid: json["uid"],
        // february: List<Month>.from(json["february"].map((x) => Month.fromJson(x))),
        // march: List<Month>.from(json["march"].map((x) => Month.fromJson(x))),
        // april: List<Month>.from(json["april"].map((x) => Month.fromJson(x))),
        // may: List<Month>.from(json["may"].map((x) => Month.fromJson(x))),
        // june: List<Month>.from(json["june"].map((x) => Month.fromJson(x))),
        // july: List<Month>.from(json["july"].map((x) => Month.fromJson(x))),
        // august: List<Month>.from(json["august"].map((x) => Month.fromJson(x))),
        // september: List<Month>.from(json["september"].map((x) => Month.fromJson(x))),
        // october: List<Month>.from(json["october"].map((x) => Month.fromJson(x))),
        // november: List<Month>.from(json["november"].map((x) => Month.fromJson(x))),
        // december: List<Month>.from(json["december"].map((x) => Month.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "isAdmin": isAdmin,
        "totalpresents": totalpresents,
        "totallates": totallates,
        "totalhalfDays": totalhalfDays,
        "totalLeaves": totalLeaves,
        "totalHolidays": totalHolidays,
        "totalUnassigned": totalUnassigned,
        "dates": dates != null
            ? List<dynamic>.from(dates.map((x) => x.toJson()))
            : [],
        "lastDate": lastDate,
        "uid": uid,
      };

  List<PieData> getYearlyDataSet() {
    List<PieData> dataSet = [];
    dataSet.add(PieData(
        "totalpresents", this.totalpresents, this.totalpresents.toString()));
    dataSet.add(
        PieData("totallates", this.totallates, this.totallates.toString()));
    dataSet.add(PieData(
        "totalhalfDays", this.totalhalfDays, this.totalhalfDays.toString()));
    dataSet.add(
        PieData("totalLeaves", this.totalLeaves, this.totalLeaves.toString()));
    dataSet.add(PieData(
        "totalAbsents", this.totalUnassigned, this.totalUnassigned.toString()));
    return dataSet;
  }

  bool getTodaysAttendance() {
    bool status = false;
    if (lastDate.year == DateTime.now().year &&
        lastDate.month == DateTime.now().month &&
        lastDate.day == DateTime.now().month) {
      status = true;
    }
    return status;
  }

  void addAttendance(Date date) {
    bool isAvailable = false;
    this.dates.forEach((element) {
      if (isSameDay(element.date, date.date)) {
        isAvailable = true;
      }
    });
    if (!isAvailable) {
      this.dates.add(date);
    }
  }

  void setLeave(DateTime date) {
    this.addAttendance(Date(date: date, status: 4));
    this.totalLeaves += 1;
  }

  String setAttendance() {
    var date = DateTime.now();

    var returnMessage = '';

    // var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");

    if (this.dates == null) {
      this.dates = [];
    }

    if (isSameDay(this.lastDate, date)) {
      returnMessage = "Attendance already set";
    } else {
      if (date.hour < 10) {
        this.dates.add(Date(date: date, status: 1)); // Present
        this.totalpresents += 1;
        this.lastDate = date;
        returnMessage = "Attendance Set";
        // users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totalpresents" : FieldValue.increment(1)});
      } else if (date.hour < 12) {
        this.dates.add(Date(date: date, status: 2)); // late
        this.totallates += 1;
        this.lastDate = date;
        returnMessage = "Late Attendance Set";
        // users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totallates" : FieldValue.increment(1)});
      } else if (date.hour < 14) {
        this.dates.add(Date(date: date, status: 3)); //  HalfDAy
        this.totalhalfDays += 1;
        this.lastDate = date;
        returnMessage = "Half-day Deducted";
        // users.doc(uid).update({"dates" : FieldValue.arrayUnion(person.dates), "totalhalfDays" : FieldValue.increment(1)});
      } else {
        returnMessage = "Time Exceeded, Couldn't Place attendance";
      }
    }
    try{
      updatePerson(this);
    } catch (e) {
      returnMessage = "${e.message}"; 
    }
    return returnMessage;
      
  }

  getCalendarAttendance(int month) {
    var calendarStatus = [];
    for (int i = 0; i <= 31; i++) {
      calendarStatus.add(0);
    }
    ;
    this.dates.forEach((element) {
      calendarStatus[element.date.day] = element.status;
    });
  }
}

class Date {
  Date({
    this.date,
    this.status,
  });

  DateTime date;
  int status;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["date"].toDate().toString()),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
      };
}

class PieData {
  final String xData;
  final num yData;
  final String text;

  PieData(this.xData, this.yData, this.text);
}

class StatsonDate {
  DateTime date;
  int status;
}
