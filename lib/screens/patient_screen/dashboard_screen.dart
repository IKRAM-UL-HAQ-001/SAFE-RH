// ignore_for_file: avoid_unnecessary_containers, camel_case_types, avoid_print, sized_box_for_whitespace, use_key_in_widget_constructors
import 'dart:async';
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:safe_rh/screens/patient_screen/appointments_detail.dart';
import 'package:safe_rh/screens/patient_screen/appointments_detail1.dart';
import 'package:safe_rh/screens/patient_screen/bgDetail.dart';
import 'package:safe_rh/screens/patient_screen/bpDetail.dart';
import 'package:safe_rh/screens/patient_screen/chat.dart';
import 'package:safe_rh/screens/patient_screen/files_screen.dart';
import 'package:safe_rh/screens/patient_screen/heartrateDetail.dart';
import 'package:safe_rh/screens/patient_screen/spO2Detail.dart';
import 'package:safe_rh/screens/patient_screen/tempratureDetail.dart';
import 'package:safe_rh/screens/patient_screen/add_doctor.dart';
import 'package:safe_rh/screens/patient_screen/add_device.dart';
import 'package:safe_rh/screens/patient_screen/navbar.dart';
import 'package:safe_rh/screens/patient_screen/vital_signs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashBoardScreen extends StatefulWidget {
  @override
  State<dashBoardScreen> createState() => _dashBoardScreenState();
}

class _dashBoardScreenState extends State<dashBoardScreen> {
  var loading=true;
  var keyUser;
  var keyUserID;
  var cookie;
  Timer? timer;
  // void bookDoctor(docId, formatted) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   keyUser = sharedPreferences.getString('key');
  //   keyUserID = sharedPreferences.getString('userId');
  //   cookie = sharedPreferences.getString('cookie');
  //   print(keyUser);
  //   print(cookie);
  //
  //   Map data = {
  //     "key": "$keyUser",
  //     "patientId": "$keyUserID",
  //   };
  //   String body = json.encode(data);
  //   print(body);
  //   try {
  //     var url = Uri.parse("http://safe-rh-mis.com/vitalsSignReal/");
  //     print(url);
  //     Response response = await http
  //         .post(url, body: body, headers: {"Cookie": "sessionid=$cookie"});
  //     print("idr h ");
  //
  //     var data = jsonDecode(response.body);
  //     // print("${data}");
  //
  //     print(data.length);
  //   } catch (e) {
  //     var a = e.toString();
  //     debugPrint(a);
  //   }
  // }

  var values = [];
  var values1 = [];

  // void getDoctors() async {
  //   var keyUser;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   keyUser = sharedPreferences.getString('key');
  //   var keyUserID = sharedPreferences.getString('userId');
  //   print(keyUser);
  //   Map data = {
  //     "key": "$keyUser",
  //     "patientID": "$keyUserID",
  //     "all": "",
  //   };
  //   String body = json.encode(data);
  //   print(body);
  //   try {
  //     var url = Uri.parse("http://safe-rh-mis.com/getAppoint/");
  //     print(url);
  //     Response response = await http.post(
  //       url,
  //       body: body,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "accept": "application/json",
  //         "Access-Control-Allow-Origin": "*",
  //       },
  //     );
  //     print("idr h ");
  //     //log(response.body);
  //     var data = jsonDecode(response.body);
  //     print("${data}");
  //   } catch (e) {
  //     var a = e.toString();
  //     debugPrint(a);
  //   }
  // }

  void getVitals() async {
    values = [];
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    print(keyUser);
    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
    };
    String body = json.encode(data);
    print(body);
    try {
      // var url = Uri.parse("http://safe-rh-mis.com/VitalsSignReal/");
      var url = Uri.parse("http://45.32.63.198:5000/livedata");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {"Cookie": "sessionid=$cookie"},
      );

      print("idr h ");
      var data = jsonDecode(response.body);
      print(response.body);
      var datalength=data.length;
      print("vital signs ${datalength}");
      for (int i = 0; i <datalength; i++) {
        values.add(data[i]);
      print("in for");
      print(values);
      }
      if(this.mounted){
      setState(() {
      });
      }
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  void initState() {
    // timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getVitals());
    getVitals();
    upcommingAppointment();
    super.initState();
  }

  var lock = true;
  @override
  Widget build(BuildContext context) {
    String a;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
      drawer: const sideBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
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
          foregroundColor: const Color(0x19ff09a9b9),
          backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
          title: const Center(
            child: Text(
              "Patient Dashboard",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff09a9b9)
              ),
            ),
          ),
        ),
      ),

      body:
      loading?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
         child:CircularProgressIndicator()
          )
        ],
      )
      :Column(

        children: [
          Row(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        color: const Color(0xff09a9b9),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.3),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const tempratureDetailPage()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'images/icons/temp.jpeg'),
                                          radius: 30.0,
                                        ),
                                      ),
                                      // }
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      (values.isNotEmpty)
                                          ? '${values[1]} C'
                                          : '0',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.3),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const spO2DetailPage()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                            'images/icons/spo2.png',
                                          ),
                                          radius: 30.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                        (values.isNotEmpty)
                                            ? '${values[2]}%'
                                            : '0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.2),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const heartRateDetailPage()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage('images/icons/hb.png'),
                                          radius: 30.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                        (values.isNotEmpty)
                                            ? '${values[0]} BPM'
                                            : '0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.2),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const bpDetailPage()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage('images/icons/bp.png'),
                                          radius: 30.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                        (values.isNotEmpty)
                                            ? '${values[8]}'"/"'${values[9]}'
                                            : '0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.2),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const bgDetailPage()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 31.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage('images/icons/bg.png'),
                                          radius: 30.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                        (values.isNotEmpty)
                                            ? '${values[11]}'
                                            : '0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
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
          Row(
            children: [
              Container(
                width: 390,
                height: 70,
                padding: const EdgeInsets.all(6),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                  children:[
                    ListTile(
                      title: Text(
                        // ignore: unnecessary_null_comparison
                        (upcommignAppointmentlist.length==0)
                        // ('${upcommignAppointmentlist[0]["date"]}'==null)
                          // ? 'No Upcomming Appointment'
                          ?'No Upcomming Appointment'
                          : 'Upcomming Appointment:  ${upcommignAppointmentlist[0]["date"]}',
                        style:
                        TextStyle(fontWeight: FontWeight.bold,color: Colors.red
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
          // lock
          //     ?

    Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(9, 15, 9, 10),
                          // padding: EdgeInsets.all(10),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddDevicePage()),
                              );
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/icons/device.png"),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DoctorsList()),
                              );
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/icons/doctor.png"),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
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
                        //             builder: (context) => const VitalSigns()),
                        //       );
                        //     },
                        //     child: Container(
                        //       height: 110,
                        //       width: 110,
                        //       decoration: const BoxDecoration(
                        //         image: DecorationImage(
                        //           scale: 4,
                        //           image:
                        //               AssetImage("images/icons/wristband.png"),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Appointments()),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const chatwithDoctor()),
                              // );
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "images/icons/appointment-history.png"),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 9.0, right: 5.0, top: 10),
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Appointments1()),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const chatwithDoctor()),
                              // );
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "images/icons/medical-report.png"),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Files(),
                                  ));
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/icons/labtest.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const chatwithDoctor()),
                              );
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/icons/chat.png"),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 9.0, right: 5.0, top: 10),
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
                        //             builder: (context) =>
                        //                 const chatwithDoctor()),
                        //       );
                        //     },
                        //     child: Container(
                        //       height: 110,
                        //       width: 110,
                        //       decoration: const BoxDecoration(
                        //         image: DecorationImage(
                        //           image: AssetImage("images/icons/chat.png"),
                        //           alignment: Alignment.topCenter,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                )
              // : Text("")
        ],
      ),
    );
  }

  var upcommignAppointmentlist = [];
  void upcommingAppointment() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "upcoming": "",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/getAppoint/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {"Cookie": "sessionid=$cookie"},
      );
      var data = jsonDecode(response.body);
      if (data.length != null) {
        for (int i = 0; i < data.length; i++) {
          upcommignAppointmentlist.add({"date": data[i]['date']});

        }
        setState(() {
          loading=false;
        });

        print(
          "this $upcommignAppointmentlist",
        );
        return;
      }
      else {
        print("aaa");
        print(values1);
        print("aaa");
        setState(() {
          loading=false;
        });
        Fluttertoast.showToast(msg: "No Appointment available");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
}
