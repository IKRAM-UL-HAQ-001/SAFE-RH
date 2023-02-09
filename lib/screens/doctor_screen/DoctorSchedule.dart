// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

// import 'dart:convert';
// import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:safe_rh/screens/doctor_screen/AddDoctorSchedule.dart';
import 'package:safe_rh/screens/doctor_screen/ShowDoctorSchedule.dart';
import 'package:safe_rh/screens/doctor_screen/UpdateDoctorSchedule.dart';

class DoctorSchedule extends StatefulWidget {
  const DoctorSchedule({Key? key}) : super(key: key);
  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}


class _DoctorScheduleState extends State<DoctorSchedule> {

  Widget build(BuildContext context) {
    double rowWidth = 10;
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("Doctor Schedule"),
        ) ,
      ),
      body:Column(
      children:[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                color: Colors.teal,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDoctorSchedule()),
                        );
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/icons/s4.png")
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text('Add New Schedule',
                                style:TextStyle(
                                    color: Colors.white,fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                height: 180,
                width: 180,
                color: Colors.teal,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateDoctorSchedule()),
                        );
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/icons/s4.png")
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text('Update Schedule',
                                style:TextStyle(
                                    color: Colors.white,fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                color: Colors.teal,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ShowDoctorSchedule()),
                        );
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/icons/s4.png")
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text('Display Schedule',
                                style:TextStyle(
                                    color: Colors.white,fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 10,),
              // Container(
              //   height: 180,
              //   width: 180,
              //   color: Colors.teal,
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => UpdateDoctorSchedule()),
              //           );
              //         },
              //         child: Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 30),
              //                 child: Container(
              //                   height: 90,
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                         image: AssetImage("images/icons/s4.png")
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: 10),
              //               Center(
              //                 child: Text('Update Schedule',
              //                   style:TextStyle(
              //                       color: Colors.white,fontSize: 15
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ),
    );
  }


}