// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:safe_rh/screens/doctor_screen/dashboard_screen.dart';
import 'package:safe_rh/screens/paramedic_screen/dashboard_screen.dart';
import 'package:safe_rh/screens/patient_screen/dashboard_screen.dart';
import 'package:safe_rh/screens/patient_screen/users_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var jo = [];
var loading=false;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum Place { phone, cnic, email }

class _LoginPageState extends State<LoginPage> {
  Place? _place;
  bool _phoneFieldVisible = false;
  bool _cnicFieldVisible = false;
  bool _emailFieldVisible = false;

  void handleSelection(Place? value) {
    setState(() {
      _place = value;
      _phoneFieldVisible = value == Place.phone;
      _cnicFieldVisible = value == Place.cnic;
      _emailFieldVisible = value == Place.email;
    });
  }

  void phonelogin(phone,password,code) async {
    jo = [];
    print("ye h ek ");
    Map data = {
      "user": phone,
      "password": password,
      "method":"phone",
      "country_code":code,
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/logIn/");
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
      print("idr h ");

      //log(response.body);

      var data = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "${data['message']}");

      print("${data}");
      if (data['multiuser'] == true) {
        for (int i = 0; i < data['users'].length; i++) {
          print(data['users'][i]['id']);
          print(data['users'][i]['fullname']);
          jo.add({
            'name': data['users'][i]['fullname'],
            'id': data['users'][i]['id']
          });
        }
        print(
          "this $jo",
        );
        setState(() {});

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UsersScree()));

        return;
      } else {
          if(data['Type']=='Patient') {
            print("patient");
            var userId = data['id'];
            var keyy = data['key'];
            var cokey = data['cookie'];
            print(userId);
            SharedPreferences sharedPreferences = await SharedPreferences
                .getInstance();
            sharedPreferences.setString('userId', userId.toString());
            sharedPreferences.setString('key', keyy);
            sharedPreferences.setString('cookie', cokey);
            showSuccessAlertDialog1(context);
          }
          else if(data['Type']=='Doctor') {
            print("Doctor");
            var userId = data['id'];
            var keyy = data['key'];
            var cokey = data['cookie'];


            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('userId', userId.toString());
            sharedPreferences.setString('key', keyy);
            sharedPreferences.setString('cookie', cokey);
            showSuccessAlertDialog2(context);
          }
          else if(data['Type']=='ParaMedic'){
            print("ParaMedic");
            var userId = data['id'];
            var keyy = data['key'];
            var cokey = data['cookie'];


            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('userId', userId.toString());
            sharedPreferences.setString('key', keyy);
            sharedPreferences.setString('cookie', cokey);
            showSuccessAlertDialog3(context);
          }
        return;
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void cniclogin(String cnic, String password) async {
    loading=true;
    jo = [];
    print("ye h ek ");
    Map data = {
      "user": cnic,
      "password": password,
      "method":"cnic",
    };
    print(data);
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/logIn/");
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
      print("idr h ");
      var data1 = jsonDecode(response.body);
      print(data1);
      Fluttertoast.showToast(msg: "${data1['message']}");
      print("${data1}");
      if (data1['multiuser'] == true) {
        for (int i = 0; i < data1['users'].length; i++) {
          print(data1['users'][i]['id']);
          print(data1['users'][i]['fullname']);
          jo.add({
            'name': data1['users'][i]['fullname'],
            'id': data1['users'][i]['id']
          });
        }
        print(
          "this $jo",
        );
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UsersScree()));
        return;
      } else {
        if(data1['Type']=='Patient'){
          print('patient');
        var userId = data1['id'];
        var keyy = data1['key'];
        var cokey = data1['cookie'];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('userId', userId.toString());
        sharedPreferences.setString('key', keyy);
        sharedPreferences.setString('cookie', cokey);

        showSuccessAlertDialog1(context);
        }
        else if(data1['Type']=='Doctor'){
          print('doctor');
          var userId = data1['id'];
          var keyy = data1['key'];
          var cokey = data1['cookie'];
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('userId', userId.toString());
          sharedPreferences.setString('key', keyy);
          sharedPreferences.setString('cookie', cokey);
          showSuccessAlertDialog2(context);
        }
        else if(data1['Type']=='ParaMedic'){
          print('ParaMedic');
          var userId = data1['id'];
          var keyy = data1['key'];
          var cokey = data1['cookie'];
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('userId', userId.toString());
          sharedPreferences.setString('key', keyy);
          sharedPreferences.setString('cookie', cokey);
          showSuccessAlertDialog3(context);
        }
        return;
      }

    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void emaillogin(String email, String password) async {
    jo = [];
    print("ye h ek ");
    Map data = {
      "user": email,
      "password": password,
      "method":"email",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/logIn/");
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
      print("idr h ");

      //log(response.body);

      var data = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "${data['message']}");

      print("${data}");
      if (data['multiuser'] == true) {
        for (int i = 0; i < data['users'].length; i++) {
          print(data['users'][i]['id']);
          print(data['users'][i]['fullname']);
          jo.add({
            'name': data['users'][i]['fullname'],
            'id': data['users'][i]['id']
          });
        }
        print(
          "this $jo",
        );
        setState(() {});

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UsersScree()));

        return;
      } else {
        if(data['Type']=='Patient') {
          print('patient');
          var userId = data['id'];
          var keyy = data['key'];
          var cokey = data['cookie'];
          print(userId);
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

          sharedPreferences.setString('userId', userId.toString());
          sharedPreferences.setString('key', keyy);
          sharedPreferences.setString('cookie', cokey);
          showSuccessAlertDialog1(context);
        }
        else if(data['Type']=='Doctor') {
          print('doctor');
          var userId = data['id'];
          var keyy = data['key'];
          var cokey = data['cookie'];
          print(userId);
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

          sharedPreferences.setString('userId', userId.toString());
          sharedPreferences.setString('key', keyy);
          sharedPreferences.setString('cookie', cokey);
          showSuccessAlertDialog2(context);
        }
        else if(data['Type']=='ParaMedic'){
          print('paremedic');
          var userId = data['id'];
          var keyy = data['key'];
          var cokey = data['cookie'];
          print(userId);
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

          sharedPreferences.setString('userId', userId.toString());
          sharedPreferences.setString('key', keyy);
          sharedPreferences.setString('cookie', cokey);
          showSuccessAlertDialog3(context);
        }
        return;
      }


    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }


  TextEditingController cnic = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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

  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var code;
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
                          title: const Text('Phone Number'),
                          value: Place.phone,
                          groupValue: _place,
                          onChanged: handleSelection),
                      if (_phoneFieldVisible)
                        GestureDetector(
                          onTap: () async {
                            final code =
                            await countryPicker.showPicker(context: context);
                            setState(() {
                              countryCode = code;
                            }
                            );
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                   code= countryCode?.dialCode ?? "+92",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_phoneFieldVisible)
                        TextFormField(
                          controller: phone,
                          decoration: const InputDecoration(
                              hintText: "Enter Phone Number",
                              labelText: "Phone Number"),
                        ),
                      if (_phoneFieldVisible)
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password Field"),
                        ),
                      RadioListTile(
                          title: const Text('Cnic Number'),
                          value: Place.cnic,
                          groupValue: _place,
                          onChanged: handleSelection),
                      if (_cnicFieldVisible)
                        TextFormField(
                          controller: cnic,
                          decoration: const InputDecoration(
                              hintText: "Enter Cnic", labelText: "Cnic Number"),
                        ),
                      // const SizedBox(height: 20),
                      if (_cnicFieldVisible)
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password Field"),
                        ),
                      RadioListTile(
                          title: const Text('Email Address'),
                          value: Place.email,
                          groupValue: _place,
                          onChanged: handleSelection),
                      if (_emailFieldVisible)
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                              hintText: "Enter Email Address",
                              labelText: "Email Address"),
                        ),
                      // const SizedBox(height: 20),
                      if (_emailFieldVisible)
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password Field"),
                        ),
                      const SizedBox(height: 20),
                      if (_phoneFieldVisible)
                        GestureDetector(
                          onTap: () async{
                            phonelogin (
                              phone.text.toString(),
                              password.text.toString(),
                              code.toString(),
                            );
                            print(phone.text.toString());
                            print(password.text.toString());
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (_cnicFieldVisible)
                        GestureDetector(
                          onTap: () {
                            cniclogin(
                              cnic.text.toString(),
                              password.text.toString(),
                            );
                            print(cnic.text.toString());
                            print(password.text.toString());
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (_emailFieldVisible)
                        GestureDetector(
                          onTap: () {
                            emaillogin(
                              email.text.toString(),
                              password.text.toString(),
                            );
                            print(email.text.toString());
                            print(password.text.toString());
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff09A9B9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
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
}

showSuccessAlertDialog1(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dashBoardScreen()));
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
showSuccessAlertDialog2(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => doctorDashBoardScreen()));
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Congratulation"),
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
showSuccessAlertDialog3(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => paramedicDashBoardScreen()));
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
// show the dialog
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