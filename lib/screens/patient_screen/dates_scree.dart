import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:safe_rh/screens/patient_screen/dashboard_screen.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DateScreen extends StatefulWidget {
final docid;
final slots;
final date;
const DateScreen({this.docid, this.slots, this.date});
  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  @override
  void initState() {
    print(jo);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select Slot",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.white,automaticallyImplyLeading: false,),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.red,
        textColor: Colors.black,
        tileColor:Colors.grey.shade200,
        style: ListTileStyle.list,
        dense: true,
        child: ListView.builder(
          itemCount:widget.slots.length,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: ()async{
                // jo[index]['id'];
                // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                //
                // sharedPreferences.setString('userId', jo[index]['id'].toString());
                 login(widget.slots[index]);
              },
              child: ListTile(
                title: Text("${widget.slots[index]}",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)),
               // subtitle: Text("ID: ${jo[index]['id']}",style: TextStyle(color: Colors.black,fontSize: 16.0)),
               // trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.login)),

              ),
            ),
          ),
        ),
      ),
    );
  }
  void login(slot) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var keyUser=sharedPreferences.getString('key');
  var  keyUserID=sharedPreferences.getString('userId');
    var cookie=sharedPreferences.getString('cookie');
    print(keyUser);
    print(cookie);
    print("ye h ek ");
    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "doctorId": "${widget.docid}",
      "date": "${widget.date}",
      "slots": "$slot",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("http://safe-rh-mis.com/takeAppoint/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Cookie":"sessionid=$cookie"

        },
      );
      print("idr h${response.body} ");
      //log(response.body);
      var data = jsonDecode(response.body);
      print("${data}");

      // for(int i=0;i<data[0].length;i++){
      //   print(data[0][i]['id']);
      //   jo.add({'name':data[0][i]['fullname'],'id':data[0][i]['id']});
      // }
      // print("this $jo",);
      // setState(() {
      //
      // });
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersScree()));


      // 3740607766041

      if (data["code"] == 201)
      {
       showSuccessAlertDialog(context);
      }else{
        showFailedAlertDialog(context);
      }

      // if(data["0"]["1"]=="id")
          {
        print("ye h ");
       // showSuccessAlertDialog(context);
      }
    }
    catch(e){
      var a = e.toString();
      debugPrint(a);
    }
  }
  showSuccessAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  dashBoardScreen()));
      },
    );
    AlertDialog alert = AlertDialog(
      title:const Text("Congratulation"),
      // content: Text(data),
      content:const Text("Your Appointment booked"),
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
}
