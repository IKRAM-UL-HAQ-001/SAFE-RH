import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Patient extends StatefulWidget {
  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  var listAll = [];

  void initState() {
    getAll();
    super.initState();
  }

  void getAll() async {
    
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');

    Map data = {
      "doctorId": "$keyUserID",
      "key": "$keyUser"
    };
    String body = json.encode(data);

    try {
      var url = Uri.parse("https://safe-rh-mis.com/getPatientList/");
      Response response = await http.post(
        url,
        body: body,
      );
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listAll.add({
            "fullname": data[i]['fullname'],
            "phone": data[i]['phone'],
          });
        }
        setState(() { });
        return;
      }
      else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "No Data available ");
        setState(() {});
      }
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 241, 245, 1),
      body: SafeArea(
        child: Column(
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
                              color: Colors.green, fontSize: 15
                            ),
                          ),
                          title: Text('${listAll[index]["fullname"]}'),

                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
