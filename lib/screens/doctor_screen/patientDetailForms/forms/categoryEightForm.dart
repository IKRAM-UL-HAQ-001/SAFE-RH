import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class categoryEightForm extends StatefulWidget {
  final Id;
  final patientId;
  const categoryEightForm({Key? key,this.Id,this.patientId});

  @override
  State<categoryEightForm> createState() => _categoryEightFormState();
}

class _categoryEightFormState extends State<categoryEightForm> {
  var loading=false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

 TextEditingController description = TextEditingController();
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
                           minLines: 4,
                           maxLines: 8,
                           maxLength: 1000,
                           keyboardType: TextInputType.multiline,
                           controller: description,
                           decoration: InputDecoration(
                             hintText: 'Description',
                             label:Text('Description'),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.0),
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             hintStyle: TextStyle(color: Color(0xff8391A1)),
                           ),
                         ),

                       ],
                     ),
                     SizedBox(height: 10,),
                     GestureDetector(
                       onTap: () {
                         postFormEightData(
                             description.text.toString());
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

 void postFormEightData(String description) async {

   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   var userid=await   sharedPreferences.getString('userId');
   var keyUser = sharedPreferences.getString('key');
   Map data = {
     "key":"$keyUser",
     "category":"8",
     "patientId":"${widget.patientId}",
     "addedBy":"userid",
     "data":{
       "Description":"$description",
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
