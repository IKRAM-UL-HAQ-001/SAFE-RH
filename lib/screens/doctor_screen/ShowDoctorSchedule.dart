// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

// import 'dart:convert';
// import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:table_calendar/table_calendar.dart';

class ShowDoctorSchedule extends StatefulWidget {
  const ShowDoctorSchedule({Key? key}) : super(key: key);
  @override
  State<ShowDoctorSchedule> createState() => _ShowDoctorScheduleState();
}


class _ShowDoctorScheduleState extends State<ShowDoctorSchedule> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  // late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
  var loading = true;
  var categories;
  var TotalSlots;
  var final_array;
  var totalslots;
  late Map<DateTime, List<Event>> _events;
  void initState() {
    GetDoctorSchedule();
    // _events = LinkedHashMap(
    //   equals: isSameDay,
    //   hashCode: getHashCode,
    // );
    // tableController = CalendarController();
    super.initState();
  }

  void GetDoctorSchedule()async{
    _events = {};
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var keyUser =sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    Map datalist = {
      "key": "${keyUser}",
      "doctorId": "${keyUserID}",
    };
    String body = json.encode(datalist);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/getDoctorSchedule/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
      );
      var data = jsonDecode(response.body);

      var StartDate=data["StartDate"];
      var  a = DateTime.parse(StartDate);

      totalslots=data['TotalSlots'].length;

      if(totalslots!=null){
        for(var i=0; i<totalslots;i++){
          TotalSlots=data['TotalSlots'][i];
          print(TotalSlots);
          final day =
          DateTime.utc(a.year, a.month, a.day);
          //   TotalSlots.add({data['TotalSlots'][i]});
          // TotalSlots.add({'slots':totalslots[i]
          // });
          //   print(TotalSlots);
          if (_events[day] == null) {
            _events[day] = [];
          }
          _events[day]!.add(a);
        }
        setState(() {
          loading = false;
        });
      }
      else{
        Fluttertoast.showToast(msg:"Doctor Schedule is not Available");
      }
    }
    catch(e){
      var a = e.toString();
      debugPrint(a);
    }
  }
  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar App')
    ),
    );
  //     body: ListView(
  //       children: [
  //         TableCalendar(
  //           eventLoader: _getEventsForTheDay,
  //           calendarFormat: _calendarFormat,
  //           onFormatChanged: (format) {
  //             setState(() {
  //               _calendarFormat = format;
  //             });
  //           },
  //           focusedDay: _focusedDay,
  //           firstDay: _firstDay,
  //           lastDay: _lastDay,
  //           onPageChanged: (focusedDay) {
  //             setState(() {
  //               _focusedDay = focusedDay;
  //             });
  //             _loadFirestoreEvents();
  //           },
  //           selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
  //           onDaySelected: (selectedDay, focusedDay) {
  //             print(_events[selectedDay]);
  //             setState(() {
  //               _selectedDay = selectedDay;
  //               _focusedDay = focusedDay;
  //             });
  //           },
  //           calendarStyle: const CalendarStyle(
  //             weekendTextStyle: TextStyle(
  //               color: Colors.red,
  //             ),
  //             selectedDecoration: BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               color: Colors.red,
  //             ),
  //           ),
  //           calendarBuilders: CalendarBuilders(
  //             headerTitleBuilder: (context, day) {
  //               return Container(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(day.toString()),
  //               );
  //             },
  //           ),
  //         ),
  //         ..._getEventsForTheDay(_selectedDay).map(
  //               (event) => EventItem(
  //               event: event,
  //               onTap: () async {
  //                 final res = await Navigator.push<bool>(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => EditEvent(
  //                         firstDate: _firstDay,
  //                         lastDate: _lastDay,
  //                         event: event),
  //                   ),
  //                 );
  //                 if (res ?? false) {
  //                   _loadFirestoreEvents();
  //                 }
  //               },
  //
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () async {
  //         final result = await Navigator.push<bool>(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => AddEvent(
  //               firstDate: _firstDay,
  //               lastDate: _lastDay,
  //               selectedDate: _selectedDay,
  //             ),
  //           ),
  //         );
  //         if (result ?? false) {
  //           _loadFirestoreEvents();
  //         }
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  }
}

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final String id;
  Event({
    required this.title,
    this.description,
    required this.date,
    required this.id,
  });
}
