import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailsCategoryTwo extends StatefulWidget {

  final Id;
  final Date;
  DetailsCategoryTwo({this.Id,this.Date});
  @override
  State<DetailsCategoryTwo> createState() => _DetailsCategoryTwoState();
}
class _DetailsCategoryTwoState extends State<DetailsCategoryTwo> {
  var test=[];
  var loading=true;
  var detaillist = [];
  var final_array =[];
  @override
  void initState() {
    getData();
    super.initState();
  }
  void getData() async {
    var detaillist = [];
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(cookie);
    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "date": "${widget.Date}",
      "category": "${widget.Id}",
    };
    String body = json.encode(data);
    print("$body");
    try {
      var url = Uri.parse("https://safe-rh-mis.com/formsDataGet/");
      print(url);
      Response response = await http.post(
        url,
        body: body,
        headers: {
          "Cookie": "sessionid=$cookie"
        },
      );
      var data = jsonDecode(response.body);
      var inner_loop_length = data[0].length;
      if(!data[0].isEmpty){
        for(int i=0;i<data.length;i++){
          for(int j=0; j<inner_loop_length;j++) {
            if(data[i][j]['Value']==''){
              print('nn');
            }
            else {
              if(data[i][j]['Value']=='[]'){
              }
              else{
                detaillist.add({
                  "label": data[i][j]['label'], "value": data[i][j]['Value']
                });
              }
            }
          }
        }
        setState(() {
          loading=false;
          final_array.addAll(detaillist);
          // print("test ${final_array[0]['value']} date:${final_array[1]['value']}");
        });
      }
      else{
        setState(() {
          loading=false;
        });
        Fluttertoast.showToast(msg:"No Data Available");
      }
    }
    catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
  @override
  Widget build(BuildContext context) {
    print(final_array.length);
    //back ja k dobara ao
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Presenting Complaint Detail",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.white,automaticallyImplyLeading: false,),
        body:loading?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child:CircularProgressIndicator()
            )
          ],
        )
        :Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  getAllAppointments(final_array),
                ],
              ),
            ),
          ],
        )
    );
  }
  Widget getAllAppointments(final_array){
    return Container(
      width: 390,
      height: 1000,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:final_array.length,
        itemBuilder: (_, index) => Card(
          margin: const EdgeInsets.all(10),
          child: InkWell(
            child: ListTile(
              title: Text("${final_array[index]['label']}",
                  style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)
              ),
              subtitle: Text("${final_array[index]['value']}",style: TextStyle(color: Colors.black,fontSize: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}