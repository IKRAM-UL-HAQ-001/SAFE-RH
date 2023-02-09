// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddDevicePage extends StatefulWidget {
  // const AddDevicePage({Key? key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  var id;
  void login(String userID, watchID
      ) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var userid=await   sharedPreferences.getString('userId');
    Map data = {
      "patientId": userid,
      "deviceId": watchID,
    };
    String body = json.encode(data);
    try {
      var url= Uri.parse("https://safe-rh-mis.com/bindDevice/");
      Response response = await http.post(url,body:body,headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      );
      if (response.statusCode == 201) {
        showSuccessAlertDialog(context);
        }
      else{
        showFailedAlertDialog(context);
      }
    } catch (e) {
      var a= e.toString();
      debugPrint (a);
    }
  }

  TextEditingController userID = TextEditingController();
  TextEditingController watchID= TextEditingController();

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'S',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff09A9B9)),
        children: [
          TextSpan(
            text: 'AFE',
            style: TextStyle(color: Color(0xff09A9B9), fontSize: 30),
          ),
          TextSpan(
            text: '-RH',
            style: TextStyle(color: Color(0xff09A9B9), fontSize: 30),
          ),
        ],
      ),
    );
  }
  void getId()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     id=await   sharedPreferences.getString('userId');
    setState(() {

    });
  }
  @override
  void initState() {
    getId();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                      // TextFormField(
                      //
                      //  enabled: false,
                      //   decoration:
                      //    InputDecoration(hintText: "$id"),
                      // ),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: watchID,
                        decoration:
                        const InputDecoration(hintText: "Enter Watch ID"),
                      ),
                      const SizedBox(height: 20),
                      // _loginAccountLabel(),
                      GestureDetector(
                        onTap: () {
                          login(
                            userID.text.toString(),
                            watchID.text.toString(),);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xff09A9B9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text("Add",
                                style: TextStyle(color: Colors.white)),
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
}

showSuccessAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("Successfully"),
    // content:const Text("Watch Binded."),
    content:const Text("Watch Binded."),
    actions: [
      okButton,
    ],
  );

// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
showFailedAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("Success"),
    content:const Text("Watch Binded."),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}