import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:safe_rh/screens/patient_screen/categories_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointments1 extends StatefulWidget {
  const Appointments1({Key? key}) : super(key: key);

  @override
  State<Appointments1> createState() => _Appointments1State();
}

class _Appointments1State extends State<Appointments1>
    with SingleTickerProviderStateMixin {
  var loading = true;
  late TabController _tabController;
  var listComp = [];
  void getComplete() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "completed": "",
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
      print("i am ");
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listComp.add({"date": data[i]['date']});
        }
        print(
          "this $listComp",
        );
        setState(() {
          loading = false;
        });
        return;
      } else {
        Fluttertoast.showToast(msg: "No slots available");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  void initState() {
    _tabController = new TabController(length: 1, vsync: this);

    getComplete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "Medical Detail of Patient",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
      body: loading
        ? Center(
          child: CircularProgressIndicator(),
        )
        : Column(
          children: [
                  Expanded(
                    child: TabBarView(
                      children: [getAllAppointments(listComp)],
                      controller: _tabController,
                    ),
                  ),
                ],
        )
    );
  }

  Widget getAllAppointments(listt) {
    return Container(
      child: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.red,
        textColor: Colors.black,
        tileColor: Colors.grey.shade200,
        style: ListTileStyle.list,
        dense: true,
        child: ListView.builder(
          itemCount: listt.length,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {},
              child: ListTile(
                title: Text("Date: ${listt[index]['date']}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                onTap: () async {
                  String date1 = "${listt[index]['date']}";
                  print("this date came $date1");
                  Navigator.push(
                      this.context,
                      MaterialPageRoute(
                          builder: (context) => Categories(date: date1)));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
