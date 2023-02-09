// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_rh/screens/doctor_screen/messages/message_screen.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/categoryListDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DocotorCard extends StatelessWidget {
  final String? DoctorName;
  final String? rating;
  final String? imagepath;
  final String? discription;
  final String? time;
  final String? appointment;
  DocotorCard(
      {@required this.DoctorName,
      @required this.discription,
      @required this.imagepath,
      @required this.rating,
      @required this.appointment,
      @required this.time
      });

  @override
  Widget build(BuildContext context) {
    var appointId=appointment;
    var patientId=DoctorName;
    return
      Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
      child: Card(
        color: Color.fromRGBO(232, 249, 249, 1),
        elevation: 5,
        child: Container(
          width: 225,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      imagepath!,
                      height: 50,
                    ),
                  ),
                  Text(
                    time!,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  DoctorName!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children : <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: ()=>{
                        getMessageScreen(patientId,appointId,context)
                      },
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
                      child: Text("Chat",textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),
                      ),
                    ),
                  ),
                  ]),
                  Row(
                      children : <Widget>[
                  // SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  categoryListDetail(patientId)),
                        );
                      },
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blue)),
                      child: Text("General \t Information",textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 13),
                      )
                    )
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
  getMessageScreen(patientId, appointId,BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    print(cookie);
    Map data = {
      "key": "$keyUser",
      "appointId": "$appointId",
      "doctorid": "$keyUserID",
      "patientId": "$patientId",
    };
    print("$data");
    if (data!=null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MessagesScreen(appointid: appointId, patientid: patientId)));
      return;
    }
    else {
      Fluttertoast.showToast(msg: "No data");
    }
  }
}
