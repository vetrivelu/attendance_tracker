// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

PersonModel personModelFromJson(String str) => PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel with ChangeNotifier{
    PersonModel({
        this.name,
        this.phone,
        this.isAdmin = false,
        this.totalpresents = 0,
        this.totallates = 0,
        this.totalhalfDays= 0,
        this.totalLeaves = 0,
        this.totalHolidays= 0,
        this.totalUnassigned= 0,
        this.dates,
        this.lastDate,
        // this.february, 
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
        dates: json["dates"]!=null?List<Date>.from(json["dates"].map((x) => Date.fromJson(x))) : null,
        lastDate: DateTime.parse(json["lastDate"].toDate().toString()),
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
        "dates": dates != null?List<dynamic>.from(dates.map((x) => x.toJson())) : null,
        "lastDate"  : lastDate
    };

      List<PieData> getYearlyDataSet() {
        List<PieData> dataSet = [];
        dataSet.add(PieData("totalpresents",this.totalpresents, this.totalpresents.toString() ));
        dataSet.add(PieData("totallates",this.totallates, this.totallates.toString()));
        dataSet.add(PieData("totalhalfDays",this.totalhalfDays, this.totalhalfDays.toString()));
        dataSet.add(PieData("totalLeaves",this.totalLeaves, this.totalLeaves.toString()));
        dataSet.add(PieData("totalHolidays",this.totalHolidays, this.totalHolidays.toString()));
      return dataSet;
    }

    bool getTodaysAttendance(){
      bool status =false;
        if(lastDate.year == DateTime.now().year && lastDate.month == DateTime.now().month && lastDate.day == DateTime.now().month){
          status = true;
      }
      return status;
    }
}

class Date {
    Date({
        this.date,
        this.status,
    });

    DateTime date;
    bool status;

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["date"].toDate().toString()),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
    };
}





class PieData{

 final String xData;
 final num yData;
 final String text;

  PieData(this.xData, this.yData, this.text);

}

class StatsonDate{
  DateTime date;
  int status;
}