import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Scedule extends StatefulWidget {
  @override
  State<Scedule> createState() => _SceduleState();
}

class _SceduleState extends State<Scedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 241, 245, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
          ),
        ),
      ),
    
    );
  }
}
