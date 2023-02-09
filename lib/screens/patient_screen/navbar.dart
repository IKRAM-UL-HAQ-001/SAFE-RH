// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:safe_rh/screens/patient_screen/add_device.dart';
import 'package:safe_rh/screens/patient_screen/dashboard_screen.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:safe_rh/src/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sideBar extends StatelessWidget {
  const sideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0,0,0,10),
        children:  [
          UserAccountsDrawerHeader(accountName: Text("Safe-rh"), accountEmail: Text("ask@safe-rh.eu"),

            currentAccountPicture: CircleAvatar (
              foregroundColor:Colors.transparent,
              backgroundImage: AssetImage("images/icons/logo.jpg"),
            ),
            decoration: BoxDecoration(
              color:Color(0xff09a9b9),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home')
            // onTap: (){
            //   onPressed: () {
            //   Navigator.push(
                // context,
                // MaterialPageRoute(
                //   builder: (context) =>
               //  dashBoardScreen()
               //  ),
               // }
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Sensor Data'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('BHU Data'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Weekly Data'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Monthly Data'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Labs Reports'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Chat with Doctor'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.recommend),
            title: Text('AI based Recommendations'),
            // onTap:() => null,
          ),          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('AI based Alerts'),
            // onTap:() => null,
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Logout'),
             onTap:() async{
               SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
               var keyUser=sharedPreferences.getString('key');
               var  keyUserID=sharedPreferences.getString('userId');
               var cookie=sharedPreferences.getString('cookie');
               print(keyUser);
               print(cookie);
               print("ye h ek ");


               try {
                 var url = Uri.parse("http://safe-rh-mis.com/logOut_api/$keyUser");
                 print(url);
                 Response response = await http.get(
                   url,

                   headers: {
                     "Cookie":"sessionid=$cookie"

                   },
                 );
                 print("idr h${response.body} ");
                 //log(response.body);
                 var data = jsonDecode(response.body);
                 print("${data}");



                 // 3740607766041

                 if (data["code"] == 201)
                 {
                   showSuccessAlertDialog(context);
                 }else{
                   Fluttertoast.showToast(msg: "Something Went Wrong");
                   // showFailedAlertDialog(context);
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

             },
          ),

      //     ListTile(
      //       leading: Icon(Icons.contact_mail),
      //       title: Text('Contact us'),
      //       // onTap:() => null,
      //     ),
        ],
      ),
    );
  }
  showSuccessAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  WelcomePage()));
      },
    );
    AlertDialog alert = AlertDialog(
      title:const Text("Congratulation"),
      // content: Text(data),
      content:const Text("You LoggedOut Successfully"),
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