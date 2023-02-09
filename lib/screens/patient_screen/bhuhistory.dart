// ignore_for_file: avoid_unnecessary_containers, camel_case_types, avoid_print
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:safe_rh/screens/patient_screen/navbar.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:badges/badges.dart';

class bhuHistory extends StatefulWidget {
  const bhuHistory({Key? key}) : super(key: key);

  @override

  State<bhuHistory> createState() => _bhuHistoryState();
}

class _bhuHistoryState extends State<bhuHistory> {

  late CrCalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=CrCalendarController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
        drawer: const sideBar(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }),
            ),
            foregroundColor: const Color(0xff09a9b9),
            backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
            title: const Center(
              child: Text(
                "Maternal History Data ",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff09a9b9)),
              ),
            ),
            actions: [
              // Badge(
              //   position: BadgePosition.topEnd(top: 10, end: 10),
              //   badgeContent: const Text(
              //     '9',
              //     style: TextStyle(color: Colors.white, height: 1, fontSize: 10),
              //   ),
              //   child: IconButton(
              //       padding:
              //       const EdgeInsets.only(left: 1.0, right: 9.0, top: 10),
              //       icon: const Icon(
              //         Icons.notifications_none,
              //         size: 40,
              //       ),
              //       onPressed: () {}),
              // ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: 390,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 9.0, right: 5.0, top: 10),
                        child: Card(
                          color: const Color(0xff09a9b9),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage:

                                          AssetImage('images/icons/temp.jpeg'),
                                          radius: 30.0,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text('78F')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                          radius: 31.0,
                                          backgroundColor: Colors.black,
                                          child: CircleAvatar(
                                            foregroundColor: Colors.transparent,
                                            backgroundImage: AssetImage(
                                              'images/icons/spo2.png',),
                                            radius: 30.0,
                                          )),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('92%')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage:
                                          AssetImage('images/icons/hb.png'),
                                          radius: 30.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('78 BPM')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                          radius: 31.0,
                                          backgroundColor: Colors.black,
                                          child: CircleAvatar(
                                            foregroundColor: Colors.transparent,
                                            backgroundImage: AssetImage(
                                                'images/icons/bp.png'),
                                            radius: 30.0,
                                          )),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('120/80')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 9.0, right: 5.0, top: 10),
                ),
                ElevatedButton(onPressed:(){_showDatePicker(context);} , child: const Text("Select a range to check")
                ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (
                //                 context) => const wristBandWeekTypeScreen()
                //         ), );},
                //     child: Container(
                //       height: 150,
                //       width: 171,
                //       decoration: const BoxDecoration(
                //         image: DecorationImage(
                //           scale: 1,
                //           image: AssetImage("images/icons/week.png"),
                //           alignment: Alignment.topCenter,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (
                //                 context) => const wristBandMonthTypeScreen()
                //         ), );},
                //     child: Container(
                //       height: 150,
                //       width: 175,
                //       decoration: const BoxDecoration(
                //         image: DecorationImage(
                //           scale: 4,
                //           image: AssetImage("images/icons/month.png"),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        )
    );
  }
  void _showDatePicker(BuildContext context) {
    showCrDatePicker(
      context,
      properties: DatePickerProperties(
        firstWeekDay: WeekDay.monday,
        pickerMode: TouchMode.rangeSelection,
        okButtonBuilder: (onPress) =>
            ElevatedButton(child: const Text('OK'), onPressed: (){
              onPress!.call();
              print("ok Pressed");
            }),
        cancelButtonBuilder: (onPress) =>
            OutlinedButton(child: const Text('CANCEL'),onPressed: (){
              onPress!.call();
              // Navigator.pop(context);
            }),
        initialPickerDate: DateTime.now(),
        onDateRangeSelected: (DateTime? rangeBegin, DateTime? rangeEnd) {
          print(rangeBegin);
          print(rangeEnd);
        },
      ),
    );
  }
 }
