import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:safe_rh/screens/patient_screen/messages/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatwithDoctor extends StatefulWidget {
  const chatwithDoctor({Key? key}) : super(key: key);

  @override
  State<chatwithDoctor> createState() => _chatwithDoctorState();
}

class _chatwithDoctorState extends State<chatwithDoctor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var listComp = [];
  var loading = true;
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
      print("i am ");
      var data = jsonDecode(response.body);
      print(data);
      print("i am ");
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listComp.add({
            "date": data[i]['date'],
            "id": data[i]['id'],
            "doc": data[i]['doc'],
            "slots": data[i]['slots']
          });
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
            "Upcomming Appointments for Chat",
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
              ));
  }

  Widget getAllAppointments(listt) {
    return Container(
      // height: MediaQuery.of(context).size.height*0.7,
      // width: MediaQuery.of(context).size.width,
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
                subtitle: Text("Time: ${listt[index]['slots']}",
                    style: TextStyle(color: Colors.black, fontSize: 16.0)),
                // trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.login)),
                onTap: () async {
                  String doctorid = "${listt[index]['doc']}";
                  String appointid = "${listt[index]['id']}";
                  debugPrint("$doctorid,$appointid");
                  // getAppointmentsdetail1(doctorid,appointid);
                  // Navigator.push(this.context,MaterialPageRoute(builder: (context)=>getAppointmentsdetail1(date:date1)));
                  getMessageScreen(doctorid, appointid);
                  // Navigator.push(this.context,MaterialPageRoute(builder: (context)=>ChatsScreen(doctorid:doctorid,appointid:appointid)));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  getAppointmentsdetail1(String appointid, doctorid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    print(cookie);
    Map data = {
      "appointId": "$appointid",
      "doctorId": "$doctorid",
      'patientId': "$keyUserID",
      "previous": ""
    };
    print("i ma ini $data");
    String body = json.encode(data);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/messageDataget/");
      print(url);
      Response response = await http.post(url, body: body, headers: {
        "Cookie": "sessionid=$cookie",
      });
      print("i am h ");
      print(response.body);
      var data = jsonDecode(response.body);
      print(data);
      if (data.length != 0) {
        // for(int i=0;i<data.length;i++){
        //   print(data[i]);
        // }
        // Navigator.push(context, MaterialPageRoute(builder:(Context)=>getAppointmentsdetail(data)));
        // return;
      } else {
        Fluttertoast.showToast(msg: "data is not available");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  getMessageScreen(doctorId, appointId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    print(cookie);
    Map data = {
      "key": "$keyUser",
      "appointId": "$appointId",
      "doctorid": "$doctorId",
      "patientId": "$keyUserID",
    };
    print("1st screen $data");
    if (data != null) {
      setState(() {});
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MessagesScreen(appointid: appointId, doctorid: doctorId)));
      return;
    } else {
      Fluttertoast.showToast(msg: "No data");
      // print("ye chota h ");
    }
  }
}
