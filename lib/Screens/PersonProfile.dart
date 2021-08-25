import 'package:attendance_tracker/models/personModel.dart';
import 'package:attendance_tracker/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class PersonProfile extends StatelessWidget {
  PersonProfile({
    this.person,
  });
  final PersonModel person;

  var firstDay = DateTime.utc(2021, 1, 1);
  var lastDay = DateTime.utc(2022, 1, 1);
  var _focusedDay = DateTime.now();


  getAttendanceonDate(DateTime date) {
    var status = 0;
    if (person.dates.isNotEmpty) {
      person.dates.forEach((element) {
        if (isSameDay(date, element.date)) {
          // print("status : ${element.status}");
          status =  element.status;
        }
      });
    }
    return status;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                GetDashboard(person: person),
                SizedBox(height: 10),
                ExpansionTile(
                  title: Text("Calendar"),
                  leading: Icon(Icons.calendar_view_month),
                  maintainState: true,
                  initiallyExpanded: true,
                  children: [
                    TableCalendar(
                      firstDay: firstDay,
                      focusedDay: _focusedDay,
                      lastDay: lastDay,
                      onDaySelected: (selectedDay, focusedDay) {
                      },
                      calendarBuilders:
                          CalendarBuilders(selectedBuilder:getSelectedBuilder , defaultBuilder: getDefaultBuilder, todayBuilder: getDefaultBuilder),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDefaultBuilder(context, DateTime day, _) {
    if (day.weekday == DateTime.sunday)
      return NormalDay(
        day: day,
      );
      var status = getAttendanceonDate(day);
      print(status);
    return Container(
      height: 40,
      width: 40,
      child: Center(
        child: Text(day.day.toString()),
      ),
      decoration: status ? BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ) : null,
    );
  }

  Widget getSelectedBuilder(context, day, _) {
    return Container(
      height: 35,
      width: 35,
      child: Center(
        child: Text(day.day.toString()),
      ),
    );
  }

}

class GetDashboard extends StatelessWidget {
  const GetDashboard({
    Key key,
    @required this.person,
  }) : super(key: key);

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Dashboard"),
      leading: Icon(Icons.dashboard),
      // maintainState: true,
      children: [
        Dashboard(person: person),
      ],
    );
  }
}

class NormalDay extends StatelessWidget {
  const NormalDay({
    Key key,
    this.day,
  }) : super(key: key);
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 43,
      child: Center(
        child: Text(
          day.day.toString(),
          style: TextStyle(color: Colors.red),
        ),
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.blue),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}
