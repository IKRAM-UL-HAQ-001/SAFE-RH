import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:safe_rh/screens/paramedic_screen/dates_scree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';


class getDoctorAppointment extends StatefulWidget {
  final patientId;
  const getDoctorAppointment({Key? key, this.patientId});

  @override
  State<getDoctorAppointment> createState() => _getDoctorAppointmentState();
}

class _getDoctorAppointmentState extends State<getDoctorAppointment> {
  var loading=true;
  var _selectedDate = null;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  void _pickDateDialog(docId,patientId) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        final String formatted = formatter.format(pickedDate);
        _selectedDate = formatted;
        bookDoctor(docId, formatted);
        loading=false;
      });
    });
  }

  var keyUser;
  var keyUserID;
  var cookie;
  var doctorList = [];
  var slots = [];
  void getDoctors() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    keyUserID = sharedPreferences.getString('userId');
    cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    print(cookie);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/doctorsList/$keyUser");
      print(url);
      Response response =
      await http.get(url, headers: {"Cookie": "sessionid=$cookie"});
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          doctorList.add({
            'name': data[i]['fullname'],
            'id': data[i]['id'],
            'address': data[i]['city'],
            'gender': data[i]['gender'],
            'specialization':data[i]['specialization']
          });
        }
        setState(() {
          loading=false;
        });
        return;
      } else {
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
  @override
  void initState() {
    getDoctors();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
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
                  }),
            ),
            foregroundColor: const Color(0xff09a9b9),
            backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
            title: const Center(
              child: Text(
                "Doctors",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff09a9b9)),
              ),
            ),
          ),
        ),
        body:loading?
        Center(
          child: CircularProgressIndicator(),
        )
        :ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () async {
              var docId=doctorList[index]['id'];
              var patientId="${widget.patientId}";
              _pickDateDialog(docId,patientId);

            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.0,
                  right: MediaQuery.of(context).size.width * 0.1,
                  left: MediaQuery.of(context).size.width * 0.1),
              child: ClayContainer(
                borderRadius: 20.0,
                spread: 4.0,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                color: baseColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (doctorList[index]['gender'] == "Male")
                        ? Image.asset(
                      "images/male.png",
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                    )
                        : Image.asset("images/icons/female.png",
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2),
                    ClayText(doctorList[index]['name'],
                        emboss: true,
                        size: MediaQuery.of(context).size.width * 0.06),
                    // ClayText(
                    //   (doctorList[index]['address'] == null)
                    //       ? ""
                    //       : doctorList[index]['address'],
                    //   emboss: true,
                    //   size: MediaQuery.of(context).size.width * 0.04,
                    //   textColor: Colors.black,
                    // ),
                    ClayText(
                      (doctorList[index]['specialization'] == null)
                          ? ""
                          : doctorList[index]['specialization'],
                      emboss: true,
                      size: MediaQuery.of(context).size.width * 0.04,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void bookDoctor(docId, formatted) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    keyUserID = sharedPreferences.getString('userId');
    cookie = sharedPreferences.getString('cookie');
    Map data = {
      "key": "$keyUser",
      "id": "$docId",
      "startDate": "$formatted",
    };
    String body = json.encode(data);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/doctorsList/");
      Response response = await http
          .post(url, body: body, headers: {"Cookie": "sessionid=$cookie"});
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          slots.add(data[i]);
        }
        setState(() {
          loading=false;
        });
        String patientId="${widget.patientId}";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => paramedicDateScreen(
                  slots: slots,
                  date: formatted,
                  docid: docId,
                  patientId: patientId,
                )
            )
        );
        return;
      } else {
        Fluttertoast.showToast(msg: "No slots available");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
}
