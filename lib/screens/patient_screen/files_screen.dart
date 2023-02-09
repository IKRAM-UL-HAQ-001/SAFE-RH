import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safe_rh/screens/patient_screen/pending.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Files extends StatefulWidget {
  const Files({Key? key}) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  var loading = true;
  var listAll = [];
  void getAll() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "uploaded": "",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/labtest_api/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Cookie": "sessionid=$cookie",
          'Content-Type': 'application/json'
        },
      );
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listAll.add({
            "date": data[i]['date'],
            "name": data[i]['name'],
            "doctor": data[i]['prescribedBy'],
            "id": data[i]['testId']
          });
        }
        setState(() {
          loading=false;
        });
        return;
      }
      else {
        Fluttertoast.showToast(msg: "No Reports available ");
      }
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void getFileDownload(var id) async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "download": "",
      "patientId": "$keyUserID",
      "testId": "$id",
    };
    String body = json.encode(data);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/labtest_api/");
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Cookie": "sessionid=$cookie",
          'Content-Type': 'application/json'
        },
      );
      var data = jsonDecode(response.body);
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PendingFiles()));
            },
            child: Icon(
              Icons.upload_file,
              color: Colors.deepPurple,
            )
          )
        ],
        title: Text(
          "Files",
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListTileTheme(
          contentPadding: const EdgeInsets.all(15),
          iconColor: Colors.red,
          textColor: Colors.black,
          tileColor: Colors.grey.shade200,
          style: ListTileStyle.list,
          dense: true,
          child: ListView.builder(
            itemCount: listAll.length,
            itemBuilder: (_, index) => Card(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  getFileDownload(listAll[index]['id']);
                },
                child: ListTile(
                    trailing: InkWell(
                        onTap: () async {
                          getFileDownload(listAll[index]['id']);
                        },
                        child: Icon(Icons.visibility)
                    ),
                    title: Text("${listAll[index]['name']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)
                    ),
                    subtitle: Text(
                      "Prescribed By: ${listAll[index]['doctor']}",
                      style:
                          TextStyle(color: Colors.black, fontSize: 16.0)
                    ),
                  ),
              ),
            ),
          ),
        ),
    );
  }
}
