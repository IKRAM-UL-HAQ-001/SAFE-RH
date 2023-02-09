import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsHistory extends StatefulWidget {
  const AppointmentsHistory({Key? key}) : super(key: key);

  @override
  State<AppointmentsHistory> createState() => _AppointmentsHistoryState();
}

class _AppointmentsHistoryState extends State<AppointmentsHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var listAll = [];
  var listCancel = [];
  var listComp = [];
  var listUpc = [];
  var loading = true;
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);

    getAll();
    getCance();
    getComplete();
    getUpc();
    super.initState();
  }

  void getAll() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "doctorId": "$keyUserID",
      "all": "",
    };
    String body = json.encode(data);
    print("..... $data");
    try {
      var url = Uri.parse("https://safe-rh-mis.com/getAppointDoc/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Cookie": "sessionid=$cookie"
        },
      );
      print("....");
      print(response.body);
      print("....");

      var data = jsonDecode(response.body);
       if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listAll.add({"date": data[i]['date'], "slots": data[i]['slots']});
        }
        print("all $listAll",);
        setState(() {
          loading=false;
        });
        return;
      } else {
         setState(() {
           loading=false;
         });
        Fluttertoast.showToast(msg: "No slots available");
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void getUpc() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "doctorId": "$keyUserID",
      "upcoming": "",
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
      print("idr h ");
      //log(response.body);
      var data = jsonDecode(response.body);
      print("${data}");
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listUpc.add({"date": data[i]['date'], "slots": data[i]['slots']});
        }
        print(
          "this $listUpc",
        );
        setState(() {
          loading=false;
        });

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DateScreen(slots: slots,date: datee,docid: docId,)));

        return;
      } else {
        Fluttertoast.showToast(msg: "No slots available");
        // 3740607766041
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void getCance() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "doctorId": "$keyUserID",
      "cancel": "",
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
      print("idr h ");
      //log(response.body);
      var data = jsonDecode(response.body);
      print("${data}");

      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listCancel.add({"date": data[i]['date'], "slots": data[i]['slots']});
        }
        print(
          "this $listCancel",
        );
        setState(() {
          loading=false;
        });

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DateScreen(slots: slots,date: datee,docid: docId,)));

        return;
      } else {
        Fluttertoast.showToast(msg: "No slots available");
        // 3740607766041
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void getComplete() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "doctorId": "$keyUserID",
      "completed": "",
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
      print("idr h ");
      //log(response.body);
      var data = jsonDecode(response.body);
      print("${data}");

      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listComp.add({"date": data[i]['date'], "slots": data[i]['slots']});
        }
        print(
          "this $listComp",
        );
        setState(() {
          loading=false;
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DateScreen(slots: slots,date: datee,docid: docId,)));
        return;
      } else {
        Fluttertoast.showToast(msg: "No slots available");
        // 3740607766041
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Appointments",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
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
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.red,
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Upcoming",
                      ),
                      Tab(
                        text: "Canceled",
                      ),
                      Tab(
                        text: "Completed",
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        getAllAppointments(listAll),
                        getAllAppointments(listUpc),
                        getAllAppointments(listCancel),
                        getAllAppointments(listComp)
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ));
  }

  Widget getAllAppointments(listt) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                subtitle: Text("Time: ${listt[index]['slots']}",
                    style: TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
