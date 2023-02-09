// ignore_for_file: unnecessary_null_comparison

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class categorySevenForm extends StatefulWidget {
  final Id;
  final patientId;
  const categorySevenForm({Key? key,this.Id,this.patientId});

  @override
  State<categorySevenForm> createState() => _categorySevenFormState();
}

class _categorySevenFormState extends State<categorySevenForm> {
  var loading=true;
  var totaldata=[];
 var finalDiagnosis;
  var totalLength;
  var splits=[];
  var x;
 @override
  void initState() {
   attributeData();
    // TODO: implement initState
    super.initState();
  }
  // TextEditingController finalDiagnosis = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
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
                          DropDownTextField(
                            // controller: finalDiagnosis,
                            // validator: (value) =>
                            // value!.length == 0 ? "Type cannot be empty" : null,
                            textFieldDecoration: InputDecoration(
                              hintText: 'Select Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintStyle: TextStyle(color: Color(0xff8391A1)),
                            ),

                            clearOption: true,
                            enableSearch: true,

                            clearIconProperty: IconProperty(color: Colors.green),
                            searchDecoration: const InputDecoration(
                                hintText: "enter your custom hint text here"),

                            // dropDownItemCount: 2000,
                            dropDownItemCount:  splits.length,

                            dropDownList:

                            [
                              for(int x=0;x< splits.length;x++)
                              DropDownValueModel(name: splits[x], value: "value${x+1}"),
                              // DropDownValueModel(name: "splits[x]", value: "value1"),

                            ],
                            onChanged: (value) {
                              finalDiagnosis=value;
                              print(finalDiagnosis.toString());
                            },
                          ),
                          SizedBox(height: 10,),

                          TextFormField(
                            controller: diagnosis,
                            decoration: InputDecoration(
                              label:Text( 'New Diagnosis'),
                              hintText: 'New Diagnosis',
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

                        ],
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          postFormSevenData(
                              diagnosis.text.toString(),finalDiagnosis);
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

 void postFormSevenData(String diagnosis,finalDiagnosis) async {

   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   var userid=await   sharedPreferences.getString('userId');
   var keyUser = sharedPreferences.getString('key');
   Map data = {
     "key":"$keyUser",
     "category":"7",
     "patientId":"${widget.patientId}",
     "addedBy":"userid",
     "data":{
       "Diagnosisfield":"$finalDiagnosis",
       "NewDiagnosis":"$diagnosis",
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

 void attributeData() async {

    try {
      var url = Uri.parse("https://safe-rh-mis.com/AttributeList/7");
      print(url);
      Response response = await http.get(
        url,
      );
      var data = jsonDecode(response.body);

      var a="${data[0]['options']}";
      var singleline = a.replaceAll("\n", '');
      List<String> x = singleline.split(",");
      totalLength=x.length;
      print(totalLength);
      for(int i=0; i<totalLength; i++){
        if(x[i]==''){
        }
        else{

           splits.add(x[i]);
           print(splits);
        }
      }
      setState(() {
        loading=false;
      });
    } catch (e) {
      var a= e.toString();
      debugPrint (a);
    }
  }
}
