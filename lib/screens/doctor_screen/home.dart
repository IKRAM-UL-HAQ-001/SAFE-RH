import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_rh/screens/doctor_screen/appointments_history.dart';
import 'package:safe_rh/screens/doctor_screen/patients.dart';
import 'package:safe_rh/screens/doctor_screen/DoctorSchedule.dart';
import 'package:safe_rh/screens/doctor_screen/widgets/appoitments_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var patients=0;
  var Paramedics=0;
  var Facilities=0;
  var Appointments=0;
  var doctordash=[];
  var ids=[];
  var patientId=[];
  var names;
 var loading=true;
 var todayAppointmentlength = 0;
 var todayList=[];
 var listAll=[];
  @override

  void initState() {
  todayAppointment();
  doctorDashboard();
  getPatientName();
    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    double imageheight = todayAppointmentlength != 0 ? 40 : 150;
    double cardHeight = todayAppointmentlength != 0 ? 160 : 250;
    double cardWidth = 180;
    double rowWidth = 10;
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: loading
            ?
        Center(
          child: CircularProgressIndicator(),
        )
        :
        SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/user_4.png')),
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Welcome ',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        names.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.menu)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'Today Appointments: ${todayAppointmentlength}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            todayAppointmentlength != 0
            ? Container(
                height: 250,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:todayList.length ,
                  itemBuilder:(_,index) =>
                      DocotorCard(
                        DoctorName: "${todayList[index]['nam']}",
                        discription: "",
                        imagepath: 'assets/images/user_4.png',
                        rating: '5.0',
                        time: "${todayList[index]['slots']}",
                        appointment: "${todayList[index]['id']}",
                      ),
                ),
                )
            : SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('pk');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Patient()),
                      );
                    },
                    child: Container(
                      height: cardHeight,
                      width: cardWidth,
                      color: Colors.white,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: imageheight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/icons/s1.png'))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Patients'),
                        Text(
                            patients.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: rowWidth,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('ss');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentsHistory()),
                      );
                    },
                    child: Container(
                      height: cardHeight,
                      width: cardWidth,
                      color: Colors.white,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: imageheight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: AssetImage('images/icons/s2.png'))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Appointments'),
                        Text(
                          Appointments.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                children: [
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: imageheight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/icons/s3.png'))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Paramedics'),
                      Text(
                        Paramedics.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ]),
                  ),
                  SizedBox(
                    width: rowWidth,
                  ),
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: imageheight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/icons/s4.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Facilities'),
                      Text(
                        Facilities.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ]),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                children: [
                  GestureDetector(
                          onTap: () {
                    print('ss');
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorSchedule()),
                    );
                    },
                  child:Container(
                    height: cardHeight,
                    width: cardWidth,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: imageheight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/icons/s3.png'))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Doctor Schedule'),
                      // Text(
                      //   Paramedics.toString(),
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 25),
                      // )
                    ]),
                  ),
                  ),
                  SizedBox(
                    width: rowWidth,
                  ),
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: imageheight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/icons/s4.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Facilities'),
                      Text(
                        Facilities.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ]),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

    void todayAppointment() async {
      var keyUser;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      keyUser = sharedPreferences.getString('key');
      var keyUserID = sharedPreferences.getString('userId');
      var cookie = sharedPreferences.getString('cookie');
      print(keyUser);

      Map data = {
        "key": "$keyUser",
        "doctorId": "$keyUserID",
        "today": "",
      };
      String body = json.encode(data);
      print(body);
      try {
        var url = Uri.parse("http://safe-rh-mis.com/getAppointDoc/");
        print(url);
        Response response = await http.post(
          url,
          body: body,
          headers: {"Cookie": "sessionid=$cookie"},
        );
        var data = jsonDecode(response.body);
        print(data);
        todayAppointmentlength=data.length;
        if (data.length != 0) {
          for (int i = 0; i < data.length; i++) {

            todayList.add({
              "date": data[i]['date'],
              "id": data[i]['id'],
              "slots": data[i]['slots'],
              "nam": data[i]['nam']
            });
          }
          setState(() {
            loading=false;
          });
          return;
        }
        else {
          // Fluttertoast.showToast(msg: "No slots available");
          setState(() {
            // loading=false;
          });
        }
      }
      catch (e) {
        var a = e.toString();
        debugPrint(a);
      }
    }

    void doctorDashboard()async{
      var keyUser;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      keyUser = sharedPreferences.getString('key');
      var keyUserID = sharedPreferences.getString('userId');
      var cookie = sharedPreferences.getString('cookie');
      Map data = {
        "key": "$keyUser",
        "doctorId": "$keyUserID",
      };
      String body = json.encode(data);
      try {
        var url = Uri.parse("http://safe-rh-mis.com/DoctorDashboardMobile/");
        Response response = await http.post(
          url,
          body: body,
          headers: {"Cookie": "sessionid=$cookie"},
        );
        var data = jsonDecode(response.body);
        if(data.length!=0){
          patients=data['Patients'];
          Appointments=data['Appointments'];
          Paramedics=data['Paramedics'];
          Facilities=data['Facilities'];
        }
        setState(() {
          loading=false;
        });
      }
      catch(e){

      }
    }

    void getPatientName() async{
      var keyUser;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      keyUser = sharedPreferences.getString('key');
      var keyUserID = sharedPreferences.getString('userId');
      var cookie = sharedPreferences.getString('cookie');
     try {
       var url = Uri.parse("https://safe-rh-mis.com/register/$keyUserID");
       print("new function $url");
       Response response = await http.get(
         url,
       );
       var data = jsonDecode(response.body);
       if(data.length!=0) {
        names=data["fullname"];
         print(names);
          setState(() {
            loading=false;
          });
          return;
       }
       else{
         Fluttertoast.showToast(msg:"No Name available ");
       }
     }
     catch(e){
       var a = e.toString();
       debugPrint(a);
     }
   }
}
