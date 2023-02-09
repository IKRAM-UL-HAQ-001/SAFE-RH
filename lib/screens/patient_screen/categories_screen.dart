import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:safe_rh/screens/patient_screen/details_category_three.dart';
import 'package:safe_rh/screens/patient_screen/details_category_eight.dart';
import 'package:safe_rh/screens/patient_screen/details_category_five.dart';
import 'package:safe_rh/screens/patient_screen/details_category_four.dart';
import 'package:safe_rh/screens/patient_screen/details_category_seven.dart';
import 'package:safe_rh/screens/patient_screen/details_category_six.dart';
import 'package:safe_rh/screens/patient_screen/details_category_two.dart';
import 'package:safe_rh/screens/patient_screen/details_category_one.dart';
import 'package:safe_rh/src/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Categories extends StatefulWidget {
  final  date;
  Categories({this.date});
  @override
  State<Categories> createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
  var loading = true;
  var categories;
  @override

  void initState() {
    print(jo);
    getCategory();
    super.initState();
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
                  String date="${widget.date}";
                  ("${categories[index]['id']}"=="1")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryOne(Id:id,Date:date))):
                  ("${categories[index]['id']}"=="2")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryTwo(Id:id,Date:date))):
                  ("${categories[index]['id']}"=="3")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryThree(Id:id,Date:date))):
                  ("${categories[index]['id']}"=="4")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryFour(Id:id,Date:date))):
                  ("${categories[index]['id']}"=="5")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryFive(Id:id,Date:date))):
                  ("${categories[index]['id']}"=="6")?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategorySix(Id:id,Date:date))):
                  ("${categories[index]['id']}"=='7')?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategorySeven(Id:id,Date:date))):
                  ("${categories[index]['id']}"=='8')?
                  Navigator.push(this.context,MaterialPageRoute(builder: (context)=>DetailsCategoryEight(Id:id,Date:date))):
                  Text("Update Category");
              },
              ),

            ),
          ),
        ),
    );
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
}
