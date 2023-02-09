// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

// import 'dart:convert';
// import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class UpdateDoctorSchedule extends StatefulWidget {
  const UpdateDoctorSchedule({Key? key}) : super(key: key);
  @override
  State<UpdateDoctorSchedule> createState() => _UpdateDoctorScheduleState();
}

enum Place { everyday, everyweek, custom }

class _UpdateDoctorScheduleState extends State<UpdateDoctorSchedule> {
  String? selected = 'Monday';
  List<String> drop = ['Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday','Sunday'];

  Place? _place;
  bool _EveryDayFieldVisible = false;
  bool _EveryWeekFieldVisible = false;
  bool _CustomFieldVisible = false;

  TextEditingController EveryDaySlots = TextEditingController();
  TextEditingController EveryDayStartDate = TextEditingController();
  TextEditingController EveryDayStartTime = TextEditingController();
  TextEditingController EveryDayEndTime = TextEditingController();

  TextEditingController EveryWeekSlots = TextEditingController();
  TextEditingController EveryWeekStartDate = TextEditingController();
  TextEditingController EveryWeekStartTime = TextEditingController();
  TextEditingController EveryWeekEndTime = TextEditingController();

  TextEditingController CustomSlots = TextEditingController();
  TextEditingController CustomStartTime = TextEditingController();
  TextEditingController CustomEndTime = TextEditingController();

  TimeOfDay Time = TimeOfDay(hour: 7, minute: 15);

  void handleSelection(Place? value) {
    setState(() {
      _place = value;
      _EveryDayFieldVisible = value == Place.everyday;
      _EveryWeekFieldVisible = value == Place.everyweek;
      _CustomFieldVisible = value == Place.custom;
    });
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Doctor Schedule',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff09A9B9)
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: height * .12),
                      _title(),
                      const SizedBox(height: 20),
                      RadioListTile(
                          title: const Text('Repeat EveryDay'),
                          value: Place.everyday,
                          groupValue: _place,
                          onChanged: handleSelection
                      ),
                      if (_EveryDayFieldVisible)
                      const SizedBox(
                        height: 10,
                      ),
                      if (_EveryDayFieldVisible)
                        TextFormField(
                          controller: EveryDayStartDate, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            label: Text("Start Date"),
                            hintText: "Start Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                EveryDayStartDate.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),
                      if (_EveryDayFieldVisible)
                      const SizedBox(
                        height: 10,
                      ),
                      if (_EveryDayFieldVisible)
                        TextFormField(
                          controller: EveryDayStartTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("Start Time"),
                            hintText: "Start Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: Time,
                            );
                            if(pickedTime != null ){
                              setState(() {
                                Time=pickedTime;
                                EveryDayStartTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                                print(EveryDayStartTime.toString());
                              }
                            );
                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_EveryDayFieldVisible)
                      const SizedBox(
                        height: 10,
                      ),
                      if (_EveryDayFieldVisible)
                        TextFormField(
                          controller: EveryDayEndTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("End Time"),
                            hintText: "End Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: Time,
                            );
                            if(pickedTime != null ){
                            setState(() {
                              Time=pickedTime;
                              EveryDayEndTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                            });
                            }
                            else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_EveryDayFieldVisible)
                      const SizedBox(
                        height: 10,
                      ),
                      if (_EveryDayFieldVisible)
                        TextFormField(
                          controller: EveryDaySlots,
                          decoration: InputDecoration(
                            label:Text( 'Slots Time'),
                            hintText: 'Slots Time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                            hintStyle:
                            TextStyle(color: Color(0xff8391A1)),
                          ),
                        ),

                      RadioListTile(
                          title: const Text('Repeat Every Week'),
                          value: Place.everyweek,
                          groupValue: _place,
                          onChanged: handleSelection),
                      if (_EveryWeekFieldVisible)
                        TextFormField(
                          controller: EveryWeekStartDate, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            label: Text("Start Date"),
                            hintText: "Start Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                EveryWeekStartDate.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),
                      if (_EveryWeekFieldVisible)
                      const SizedBox(height: 10),
                      if (_EveryWeekFieldVisible)
                        TextFormField(
                          controller: EveryWeekStartTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("Start Time"),
                            hintText: "Start Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: Time,
                            );
                            if(pickedTime != null ){
                              setState(() {
                                Time=pickedTime;
                                EveryWeekStartTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                                print(EveryWeekStartTime);
                              }
                              );
                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_EveryWeekFieldVisible)
                        const SizedBox(height: 10),
                      if (_EveryWeekFieldVisible)
                        TextFormField(
                          controller: EveryWeekEndTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("End Time"),
                            hintText: "End Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: Time,
                            );
                            if(pickedTime != null ){
                              setState(() {
                                Time=pickedTime;
                                EveryWeekEndTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                              }
                              );
                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_EveryWeekFieldVisible)
                        const SizedBox(height: 10),
                      if (_EveryWeekFieldVisible)
                        TextFormField(
                          controller: EveryWeekSlots,
                          decoration: InputDecoration(
                            label:Text( 'Slots Time'),
                            hintText: 'Slots Time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(color: Color(0xff8391A1)),
                          ),
                        ),

                      RadioListTile(
                          title: const Text('Custom'),
                          value: Place.custom,
                          groupValue: _place,
                          onChanged: handleSelection
                      ),
                      if (_CustomFieldVisible)
                        Row(
                          children: [
                            const Text(
                              'Choose method to Sign in:',
                              style: TextStyle(
                                color: Color.fromRGBO(29, 191, 193, 1),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .030,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                iconSize: height * 0.044,
                                disabledHint: null,
                                hint: Text(
                                  'Method:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                items: drop
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item.toString(),
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size.height * 0.020,
                                        ),
                                      ),
                                    ),
                                ).toList(),
                                value: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selected = value as String;
                                  });
                                },
                                buttonHeight: height1 * 0.041,
                                buttonWidth: width * 0.4,
                                itemHeight: height1 * 0.041,
                              ),
                            ),
                          ],
                        ),
                      if (_CustomFieldVisible)
                        const SizedBox(
                        height: 10,
                      ),
                      if (_CustomFieldVisible)
                        TextFormField(
                          controller: CustomStartTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("Start Time"),
                            hintText: "Start Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: Time,
                            );
                            if(pickedTime != null ){
                              setState(() {
                                Time=pickedTime;
                                CustomStartTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                                print(CustomStartTime);
                              }
                              );
                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_CustomFieldVisible)
                        const SizedBox(height: 10),
                      if (_CustomFieldVisible)
                        TextFormField(
                          controller: CustomEndTime, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time), //icon of text field
                            label: Text("End Time"),
                            hintText: "End Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: Time,
                            );
                            if(pickedTime != null ){
                              setState(() {
                                Time=pickedTime;
                                CustomEndTime.text= Time.hour.toString()+':'+ Time.minute.toString()+':00';
                                print(CustomEndTime);
                              });
                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      if (_CustomFieldVisible)
                        const SizedBox(height: 10),
                      if (_CustomFieldVisible)
                        TextFormField(
                          controller: CustomSlots,
                          decoration: InputDecoration(
                            label:Text( 'Slots Time'),
                            hintText: 'Slots Time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                            hintStyle:
                            TextStyle(color: Color(0xff8391A1)),
                          ),
                        ),
                      if (_CustomFieldVisible)
                        const SizedBox(height: 20),

                      if (_EveryDayFieldVisible)
                        GestureDetector(
                          onTap: () async{
                            EveryDay (
                              EveryDayStartDate.text.toString(),
                              EveryDayStartTime.text.toString(),
                              EveryDayEndTime.text.toString(),
                              EveryDaySlots.text.toString(),
                            );
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (_EveryWeekFieldVisible)
                        GestureDetector(
                          onTap: () {
                            EveryWeek(
                              EveryWeekStartDate.text.toString(),
                              EveryWeekStartTime.text.toString(),
                              EveryWeekEndTime.text.toString(),
                              EveryWeekSlots.text.toString(),
                            );
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (_CustomFieldVisible)
                        GestureDetector(
                          onTap: () {
                            Custom(
                              CustomStartTime.text.toString(),
                              CustomEndTime.text.toString(),
                              CustomSlots.text.toString(),
                            );
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }

void EveryDay(EveryDayStartDate,EveryDayStartTime,EveryDayEndTime,EveryDaySlots) async {
  var keyUser;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  keyUser = sharedPreferences.getString('key');
  var keyUserID = sharedPreferences.getString('userId');

  Map datalist = {
    "key": "${keyUser}",
    "doctorId": "${keyUserID}",
    "schedule": {
    "StartDate" : "${EveryDayStartDate}",
    "StartTime": "${EveryDayStartTime}",
    "EndTime": "${EveryDayEndTime}",
    "slot": "${EveryDaySlots}",
    "repeat_All": 1,
    "repeat_Specific": 0,
    "repeat_Custom": 0,
    }
  };
  String body = json.encode(datalist);
  print(body);
  try {
    var url = Uri.parse("http://safe-rh-mis.com/createDoctorSchedule/");
    print(url);
    Response response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    var data = jsonDecode(response.body);
    print(data);
    Fluttertoast.showToast(msg: "${data}");
  }
  catch (e) {
    var a = e.toString();
    debugPrint(a);
  }
}
void EveryWeek(EveryWeekStartDate,EveryWeekStartTime,EveryWeekEndTime,EveryWeekSlots) async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');

    Map datalist = {
      "key": "${keyUser}",
      "doctorId": "${keyUserID}",
      "schedule": {
        "StartDate" : "${EveryWeekStartDate}",
        "StartTime": "${EveryWeekStartTime}",
        "EndTime": "${EveryWeekEndTime}",
        "slot": "${EveryWeekSlots}",
        "repeat_All": "0",
        "repeat_Specific": "1",
        "repeat_Custom": "0",
      }
    };
    String body = json.encode(datalist);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/createDoctorSchedule/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      );
      var data = jsonDecode(response.body);
      print(data);
      Fluttertoast.showToast(msg: "${data}");
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
void Custom(CustomStartTime,CustomEndTime,CustomSlots) async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');

    Map datalist = {
      "key" : "${keyUser}",
      "doctorId"  : "${keyUserID}",
      "schedule"  : {
        "StartDate" : "",
        "StartTime" : "${CustomStartTime}",
        "EndTime" : "${CustomEndTime}",
        "slot"  : "${CustomSlots}",
        "repeat_All"  : "0",
        "repeat_Specific" : "0",
        "repeat_Custom" : "1",
        "uncheckedSlots": null,
        "daily":[
          {
            "Day": "${selected}",
          }
        ]
      }
    };
    String body = json.encode(datalist);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/createDoctorSchedule/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      );
      var data = jsonDecode(response.body);
      print(data);
      Fluttertoast.showToast(msg: "${data}");
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

}

showSuccessAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => dashBoardScreen()));
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Congratulation"),
    // content: Text(data),
    content: const Text("you are Login Successful."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showFailedAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Failed"),
    content: const Text("Invalid Credentials."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}