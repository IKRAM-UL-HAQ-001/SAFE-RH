import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class VitalSigns extends StatefulWidget {
  const VitalSigns({Key? key}) : super(key: key);
  @override
  State<VitalSigns> createState() => _VitalSignsState();
}

class _VitalSignsState extends State<VitalSigns> {
  var listAll=[];
  void getAll()async{
    var keyUser;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    keyUser=sharedPreferences.getString('key');
    var keyUserID=sharedPreferences.getString('userId');
    var cookie=sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "uploaded": "",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/vitals/$keyUserID");
      print(url);
      Response response = await http.get(
        url,
      );
      print("idr h ");
      // log(response.body);
      var data = jsonDecode(response.body);
      print("${data}");
      //
      if(data.length!=0){
var datee;
        for(int i=0;i<data.length;i++){
          datee=data[i]['data'];

          listAll.add({"date":data[i]['date'],"name":data[i]['Name'],"value":data[i]['value'],"id":data[i]['testId'],"nam":data[i]['nam'],"upload":data[i]['uploadTime']});
        }
        print("this $listAll",);
        setState(() {

        });

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DateScreen(slots: slots,date: datee,docid: docId,)));

        return;
      }
      else{
        Fluttertoast.showToast(msg:"No Data available ");
        // 3740607766041
        print("ye chota h ");
      }

    }

    catch(e){
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          foregroundColor: const Color(0xff09a9b9),
          backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
          title: const Center(
            child: Text(
              "Device Vitalsigns ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff09a9b9)),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount:listAll.length,
        itemBuilder: (_, index) => Card(
          margin: const EdgeInsets.all(10),
            child: ExpansionTile(
              title: Text(
                listAll[index]['date'],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                  "Name: ${listAll[index]["name"]}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: Text(
                  "value: ${listAll[index]["value"]}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: Text(
                  "nam: ${listAll[index]["nam"]}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
                ListTile(
                  title: Text(
                    "UploadTime: ${listAll[index]["upload"]}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
