import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categoryEightForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categoryFourForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categoryOneForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categoryFiveForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categorySevenForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categorySixForm.dart';
import 'package:safe_rh/screens/doctor_screen/patientDetailForms/forms/categoryTwoForm.dart';


class categoryListDetail extends StatefulWidget {
  final patientId;
  const categoryListDetail(this.patientId);
  @override
  State<categoryListDetail> createState() => _categoryListDetailState();
}
class _categoryListDetailState extends State<categoryListDetail> {
  var loading = true;
  var categories;

  void initState() {
    getCategory();
    super.initState();
  }

  void getCategory()async{
    var keyUser;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    keyUser=sharedPreferences.getString('key');
    print(keyUser);

    try {
      var url = Uri.parse("http://safe-rh-mis.com/CategoryList/");
      print(url);
      Response response = await http.get(
        url,
      );
      print("idr h ");
      var data = jsonDecode(response.body);
      print("${data}");
      if(data!=null){
        categories=data;
        setState(() {
          loading = false;
        });
      }
      else{
        Fluttertoast.showToast(msg:"No Categories available");
        print("ye chota h ");
      }
    }
    catch(e){
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select Category",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.white,automaticallyImplyLeading: false,),
      body: loading
          ? Center(child: CircularProgressIndicator())
          :ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.red,
        textColor: Colors.black,
        tileColor:Colors.grey.shade200,
        style: ListTileStyle.list,
        dense: true,
        child: ListView.builder(
          itemCount:categories.length,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(" ${categories[index]['AlliasName']}",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)),
              onTap: () async{
                String id="${categories[index]['id']}";
                String patientid="${widget.patientId}";
                ("${categories[index]['id']}"=="1")?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryOneForm(Id:id,patientId:patientid))):
                ("${categories[index]['id']}"=="2")?
                    Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryTwoForm(Id:id,patientId:patientid))):
                // ("${categories[index]['id']}"=="3")?
                // Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryThreeForm(Id:id,))):
                ("${categories[index]['id']}"=="4")?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryFourForm(Id:id,patientId:patientid))):
                ("${categories[index]['id']}"=="5")?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryFiveForm(Id:id,patientId:patientid))):
                ("${categories[index]['id']}"=="6")?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categorySixForm(Id:id,patientId:patientid))):
                ("${categories[index]['id']}"=='7')?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categorySevenForm(Id:id,patientId:patientid))):
                ("${categories[index]['id']}"=='8')?
                Navigator.push(this.context,MaterialPageRoute(builder: (context)=>categoryEightForm(Id:id,patientId:patientid))):
                Text("Update Category");
              },
            ),

          ),
        ),
      ),
    );
  }


}