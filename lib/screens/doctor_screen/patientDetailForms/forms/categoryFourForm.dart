import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;


class categoryFourForm extends StatefulWidget {
  final Id;
  final patientId;
  const categoryFourForm({Key? key, this.Id,this.patientId});

  @override
  State<categoryFourForm> createState() => _categoryFourFormState();
}

class _categoryFourFormState extends State<categoryFourForm> {
  var loading=false;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
 TextEditingController PrescriptionComment = TextEditingController();
 TextEditingController PrescriptionMedicine = TextEditingController();
 TextEditingController MedicineStrength = TextEditingController();
 TextEditingController StrengthUnit = TextEditingController();
 TextEditingController NoOfUnits = TextEditingController();
 TextEditingController Frequency = TextEditingController();
 TextEditingController StartDate = TextEditingController();
 TextEditingController Route = TextEditingController();
 TextEditingController NoOfDays = TextEditingController();


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
                  height: 10,
                  // height: height * .12,
                ),
                Form(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("General",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          // SizedBox(height: 10,),
                          TextFormField(
                            controller: PrescriptionComment,
                            decoration: InputDecoration(
                              label:Text( 'Prescription Comment'),
                              hintText: 'Prescription Comment',
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
                            controller: PrescriptionMedicine,
                            decoration: InputDecoration(
                              label:Text( 'Prescription Medicine'),
                              hintText: 'Prescription Medicine',
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
                            controller: MedicineStrength,
                            decoration: InputDecoration(
                              label:Text( 'Medicine Strength'),
                              hintText: 'Medicine Strength',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: StrengthUnit,
                            decoration: InputDecoration(
                              label:Text( 'Strength Unit'),
                              hintText: 'Strength Unit',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: NoOfUnits,
                            decoration: InputDecoration(
                              label:Text( 'No Of Units '),
                              hintText: 'No Of Units ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: Frequency,
                            decoration: InputDecoration(
                              label:Text( 'Frequency'),
                              hintText: 'Frequency',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: StartDate,
                            decoration: InputDecoration(
                              label:Text( 'Start Date'),
                              hintText: 'Start Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: Route,
                            decoration: InputDecoration(
                              label:Text( 'Route'),
                              hintText: 'Route',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: StartDate,
                            decoration: InputDecoration(
                              label:Text( 'Start Date'),
                              hintText: 'Start Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          postFormOneData(
                              PrescriptionComment.text.toString(),PrescriptionMedicine.text.toString(),MedicineStrength.text.toString(),StrengthUnit.text.toString(),
                              NoOfUnits.text.toString(),Frequency.text.toString(),StartDate.text.toString(),
                              Route.text.toString());
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

 void postFormOneData(String PrescriptionComment,PrescriptionMedicine,MedicineStrength,StrengthUnit,NoOfUnits,Frequency,
     StartDate,Route) async {

   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   var userid=await   sharedPreferences.getString('userId');
   var keyUser = sharedPreferences.getString('key');
   Map data = {
     "key":"$keyUser",
     "category":"4",
     "patientId":"${widget.patientId}",
     "addedBy":"userid",
     "data":{
       "PrescriptionComment":"$PrescriptionComment",
       "PrescriptionMedicine":"$PrescriptionMedicine",
       "MedicineStrength":"$MedicineStrength",
       "StrengthUnit":"$StrengthUnit",
       "NoOfUnits":"$NoOfUnits",
       "Frequency":"$Frequency",
       "StartDate":"$StartDate",
       "Route":"$Route",
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
