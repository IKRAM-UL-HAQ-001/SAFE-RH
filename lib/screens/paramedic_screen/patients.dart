import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:safe_rh/screens/paramedic_screen/doctorAppointment.dart';
import 'package:safe_rh/screens/paramedic_screen/registerPatient.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Patient extends StatefulWidget {
  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  var laoding=true;
  @override
  void initState() {
    getAll();
    // TODO: implement initState
    super.initState();
  }

  var listAll = [];

  void getAll() async {
    
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "doctorId": "$keyUserID",
      "key": "$keyUser"
    };
    String body = json.encode(data);

    try {
      var url = Uri.parse("https://safe-rh-mis.com/getPatientList/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
      );
      var data = jsonDecode(response.body);
      print(data.length);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listAll.add({
            "id":data[i]["id"],
            "fullname": data[i]['fullname'],
            "phone": data[i]['phone'],
          });
        }
        setState(() {
        loading=false;
        });
        return;
      }
      else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "No Data available ");
        setState(() {
          loading=false;
        });
        print("ye chota h ");
      }
    } catch (e) {
      print('error');
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 241, 245, 1),
      body: loading ?
      Center(
        child: CircularProgressIndicator(),
      )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PATIENTS',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon:Icon(
                      Icons.add_circle_rounded,
                      size: 40,
                    ),
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  registerNewPatient()),
                      );
                    } ,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: ListView.builder(
                  itemCount: listAll.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        color: Color.fromRGBO(240, 251, 252, 1),
                        height: 80,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'images/icons/logo.png')),
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          trailing:  Text(
                            "${listAll[index]['phone']}",
                            style: TextStyle(
                                color: Colors.green, fontSize: 15),
                          ),
                          title: Text('${listAll[index]["fullname"]}'),
                          subtitle: Center(
                              child: Column(
                                children: <Widget>[
                                  TextButton(
                                    onPressed:(){
                                      String patientId="${listAll[index]['id']}";
                                      print(patientId);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  getDoctorAppointment(patientId:patientId)),
                                      );
                                    },
                                    child: Text("Book Appointment",textAlign: TextAlign.center,),
                                  ),
                                ]
                              ),
                            ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      );
    }
}
