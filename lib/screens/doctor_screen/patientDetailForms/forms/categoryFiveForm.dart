import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class categoryFiveForm extends StatefulWidget {
  final Id;
  final patientId;
  const categoryFiveForm({Key? key,this.Id,this.patientId});

  @override
  State<categoryFiveForm> createState() => _categoryFiveFormState();
}

class _categoryFiveFormState extends State<categoryFiveForm> {
  var loading=false;
 @override
  void initState() {
    // TODO: implement initState
   dateinput.text = "";
    super.initState();
  }
 TextEditingController dateinput = TextEditingController();
  TextEditingController labtest = TextEditingController();
 @override
 Widget build(BuildContext context) {
   double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
   return Scaffold(
     backgroundColor: Color.fromRGBO(235, 241, 245, 1),
     body: loading
         ? Center(child: CircularProgressIndicator())
         : SafeArea(
       child: Padding(
         padding:
         const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         child: SingleChildScrollView(
           // physics: NeverScrollableScrollPhysics(),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(
                 // height: 10,
                 height: height * .12,
               ),
               Form(
                 child: Column(
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 10,),
                         TextFormField(
                           controller: labtest,
                           decoration: InputDecoration(
                             label:Text( 'Lab Test Name'),
                             hintText: 'Lab Test Name',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.0),
                               borderSide:
                               BorderSide(color: Colors.white),
                             ),
                             hintStyle: TextStyle(color: Color(0xff8391A1)),
                           ),
                         ),
                         SizedBox(
                           height:10,
                         ),
                         TextFormField(
                           controller: dateinput, //editing controller of this TextField
                           decoration: InputDecoration(
                             icon: Icon(Icons.calendar_today), //icon of text field
                             label: Text("Choose Date"),
                             hintText: "Choose Date",
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.0),
                               borderSide:
                               BorderSide(color: Colors.white),
                             ),
                           ),
                           readOnly: true,
                           onTap: () async {
                             DateTime? pickedDate = await showDatePicker(
                                 context: context, initialDate: DateTime.now(),
                                 firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                 lastDate: DateTime(2101)
                             );
                             if(pickedDate != null ){
                               print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                               String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                               print(formattedDate); //formatted date output using intl package =>  2021-03-16
                               setState(() {
                                 dateinput.text = formattedDate; //set output date to TextField value.
                               });
                             }else{
                               print("Date is not selected");
                             }
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 10,),
                     GestureDetector(
                       onTap: () {
                         postFormFiveData(
                             labtest.text.toString(),dateinput.text.toString());
                       },
                       child: Container(
                         height: height * 0.059,
                         width: width * 0.687,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           color: Color.fromRGBO(29, 191, 193, 1),
                         ),
                         child: Center(
                             child: Text(
                               'Save',
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: height * 0.020),
                             )
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     ),
   );
 }

  void postFormFiveData(String labtest,dateinput) async {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var userid=await   sharedPreferences.getString('userId');
    var keyUser = sharedPreferences.getString('key');
    Map data = {
      "key":"$keyUser",
      "category":"5",
      "patientId":"${widget.patientId}",
      "addedBy":"userid",
      "data":{
        "LabtestName":"$labtest",
        "datelab":"$dateinput",
      }
    };
    print("data is $data");
    String body = json.encode(data);
    try {
      var url= Uri.parse("https://safe-rh-mis.com/DynamicformsSave/");
      Response response = await http.post(url,body:body,headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      );
      print(response.body);
      // if (response.statusCode == 201) {
      //   showSuccessAlertDialog(context);
      // }
      // else{
      //   showFailedAlertDialog(context);
      // }
    } catch (e) {
      var a= e.toString();
      debugPrint (a);
    }
  }
}



