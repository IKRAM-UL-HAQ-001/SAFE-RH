// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:convert';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var listAll=[];
  var controllerOtp = TextEditingController();
  String? duplicate = "";

  void initState() {
    // getdistrictlist();
    super.initState();
  }

  void registration(String fullName, password, cnicNumber,code, phoneNumber, address, city,email,
      select, selectUserType) async {
    Map data = {
      "fullname": fullName,
      "password": password,
      "cnic": cnicNumber,
      "country_Code": code,
      "phone": phoneNumber,
      "city": city,
      "address": address,
      "email": email,
      "gender": select,
      "Type": selectUserType,
    };
    print("first $data");
    String body = json.encode(data);
    debugPrint("first body $body");
    try {
      var url = Uri.parse("https://safe-rh-mis.com/register/");
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("first after decode");
      print(response.body);
      var resp = json.decode(response.body);
      var a = resp['code'].toString();
      print("first after decode");
      print(resp['code'].toString());
      print("first after decode");
      if (a == "102") {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                    "You are already Registered. Do you want to Create Another Account"),
                actions: [
                  TextButton(
                      onPressed: () {
                        duplicateregistration(
                          fullName,
                          password,
                          cnicNumber,
                          code,
                          phoneNumber,
                          city,
                          address,
                          email,
                          select,
                          selectUserType,
                          duplicate,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                ],
              );
            });
      } else if (a == "201") {
        showSuccessAlertDialog(context);
      } else {
        showFailedAlertDialog(context);
      }
    } catch (e) {
      String data = e.toString();
      debugPrint(data);
    }
  }

  void duplicateregistration(String fullName, password, cnicNumber,code, phoneNumber,
      city, address,email,select, selectUserType, duplicate) async {
    Map data = {
      "fullname": fullName,
      "password": password,
      "cnic": cnicNumber,
      "country_Code": code,
      "phone": phoneNumber,
      "city": city,
      "address": address,
      "email": email,
      "gender": select,
      "Type": selectUserType,
      "duplicate": "",
    };

    String body = json.encode(data);
    debugPrint("this is my name $body");
    try {
      var url = Uri.parse("https://safe-rh-mis.com/register/");
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      var ab=jsonDecode(response.body);
      print("secoond time $ab");
      if (response.statusCode == 201) {
        showSuccessAlertDialog(context);
      } else {
        showFailedAlertDialog(context);
      }
    } catch (e) {
      String data = e.toString();
      debugPrint(data);
    }
  }

  void sendOtp(var number, String code) async {
    jo = [];
    print("otp verification ");
    Map data = {
      "country_code":"$code",
      "phone": "$number",
    };
    String body = json.encode(data);
    print(body);
    // 3740607766041
    try {
      var url = Uri.parse("http://safe-rh-mis.com/GetOtps/");
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

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Otp sent to your mobile number");
        var otp = data['otp'];
        print(otp);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Enter Otp"),
                content: TextField(
                  controller: controllerOtp,
                  decoration: InputDecoration(hintText: "Enter Otp"),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (otp == controllerOtp.text) {
                          registration(
                            fullName.text.toString(),
                            password.text.toString(),
                            cnicNumber.text.toString(),
                            code,
                            phoneNumber.text.toString(),
                            city.text.toString(),
                            address.text.toString(),
                            email.text.toString(),
                            select,
                            selectUserType,
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Ooooops! You Enter Wrong Otp... Try Again!");
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                ],
              );
            });
      } else {
        Fluttertoast.showToast(msg: "Try Again!");
      }

    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  TextEditingController password = TextEditingController();
  TextEditingController cnicNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();

  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  String? select = 'Other';
  String? selectUserType = 'Other';
  @override

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    String code;
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
                      TextFormField(
                        controller: fullName,
                        decoration: const InputDecoration(
                            hintText: "Enter Full Name",
                            labelText: "Full Name"),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Enter Correct Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: cnicNumber,
                        decoration: const InputDecoration(
                            hintText: "Enter Cnic Number 37406123456789",
                            labelText: "Cnic Number"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            hintText: "Enter Email Address test@test.com",
                            labelText: "Email Address"),
                      ),
                      const SizedBox(height: 20,),
                      Column(
                        children: [
                          Row(
                            children: [
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
                                        code= countryCode?.dialCode ?? "+1",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child:
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                controller: phoneNumber,
                                decoration: const InputDecoration(
                                  hintText: "Enter Phone Number 3431234567",
                                  labelText: "Phone Number",),
                              ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: city,
                        decoration: const InputDecoration(
                            hintText: "Enter City Name",
                            labelText: "City Name"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: address,
                        decoration: const InputDecoration(
                            hintText: "Enter Address",
                            labelText: "Address"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password Field"),
                        validator: (value) {
                          return "Enter Correct Password";
                        },
                      ),
                      const SizedBox(height: 20),
                      Column(children: [
                        Row(children: [
                          const Text(
                            "Select Gender",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                        ]),
                        Row(children: [
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 'Male',
                            groupValue: select,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                select = value! as String?;
                              });
                            },
                          ),
                          const Text("Male"),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 'Female',
                            groupValue: select,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                select = value! as String?;
                              });
                            },
                          ),
                          const Text("Female"),
                        ]),
                      ]),

                      const SizedBox(height: 10),

                      Column(children: [
                        Row(children: [
                          const Text(
                            "Select User Type",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                        ]),
                        Row(children: [
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 'Patient',
                            groupValue: selectUserType,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                selectUserType = value! as String?;
                              });
                            },
                          ),
                          const Text("Patient"),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 'Doctor',
                            groupValue: selectUserType,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                selectUserType = value! as String?;
                              });
                            },
                          ),
                          const Text("Doctor"),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 'ParaMedic',
                            groupValue: selectUserType,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                selectUserType = value! as String?;
                              });
                            },
                          ),
                          const Text("ParaMedic"),
                        ]),
                      ]),

                      const SizedBox(height: 20),
                      // const SizedBox(height: 20),
                      _loginAccountLabel(),
                      GestureDetector(
                        onTap: () async {
                          sendOtp(phoneNumber.text,code,);
                          // registration(fullName.text.toString(), password.text.toString(), cnicNumber.text.toString(),code.toString(),
                          //     phoneNumber.text.toString(), address.text.toString(),
                          //     city.text.toString(), email.text.toString(), select, selectUserType);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xff09A9B9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text("Register Now",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }

  showSuccessAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Congratulation"),
      // content: Text(data),
      content: const Text("You Are Successfully Registered."),
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
      title: const Text("Failed!"),
      content:
      const Text("You Can't Registered. Please enter Correct Information"),
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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left,
                  color: Color(0xff09A9B9)),
            ),
            const Text('Back',
                style: TextStyle(
                    color: Color(0xff09A9B9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff09A9B9),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

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
          ]),
    );
  }
}
