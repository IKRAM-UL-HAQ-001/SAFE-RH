import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UsersScree extends StatefulWidget {

  @override
  State<UsersScree> createState() => _UsersScreeState();
}

class _UsersScreeState extends State<UsersScree> {
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
      appBar: AppBar(title: Text("Select User",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.white,automaticallyImplyLeading: false,),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.red,
        textColor: Colors.black,
        tileColor:Colors.grey.shade200,
        style: ListTileStyle.list,
        dense: true,
        child: ListView.builder(
          itemCount:jo.length,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: ()async{
                jo[index]['id'];
                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

                sharedPreferences.setString('userId', jo[index]['id'].toString());

                login("3740607766041", "${jo[index]['id']}");
              },
              child: ListTile(
                title: Text("${jo[index]['name']}",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)),
                subtitle: Text("ID: ${jo[index]['id']}",style: TextStyle(color: Colors.black,fontSize: 16.0)),
                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.login)),

              ),
            ),
          ),
        ),
      ),
    );
  }
  void login(String password, cnic) async {
    print("ye h ek ");
    Map data = {
      "id": "$cnic",
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
      print("${data}");
      var userId=data['id'];
      var keyy=data['key'];
      var cokey=data['cookie'];
      print(cokey);
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString('userId', userId.toString());
      sharedPreferences.setString('key', keyy);
      sharedPreferences.setString('cookie', cokey);
          {
            print("ye h ");
        showSuccessAlertDialog1(context);
      }
    }
    catch(e){
      var a = e.toString();
      debugPrint(a);
    }
  }
}
