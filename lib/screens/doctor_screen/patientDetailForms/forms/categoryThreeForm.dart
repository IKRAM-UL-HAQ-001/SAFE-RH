import 'package:flutter/material.dart';


class categoryOneForm extends StatefulWidget {
  const categoryOneForm({Key? key, required String Id}) : super(key: key);

  @override
  State<categoryOneForm> createState() => _categoryOneFormState();
}

class _categoryOneFormState extends State<categoryOneForm> {
 var  loading=false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
 TextEditingController bodyWeight = TextEditingController();
 TextEditingController bodyHeight = TextEditingController();
 TextEditingController bmi = TextEditingController();
 TextEditingController bodyTemprature = TextEditingController();
 TextEditingController heartRate = TextEditingController();
 TextEditingController oxygenSaturation = TextEditingController();
 TextEditingController respirationRate = TextEditingController();
 TextEditingController glucoseLevel = TextEditingController();
 TextEditingController systolicBP = TextEditingController();
 TextEditingController diastolicBP = TextEditingController();
 TextEditingController gestationalAge = TextEditingController();
 TextEditingController single_twin = TextEditingController();
 TextEditingController miscarriage = TextEditingController();
 TextEditingController gravida = TextEditingController();
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
                          Text("General",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: bodyWeight,
                            decoration: InputDecoration(
                              label:Text( 'Body Weight'),
                              hintText: 'Body Weight',
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
                            controller: bodyHeight,
                            decoration: InputDecoration(
                              label:Text( 'Height'),
                              hintText: 'Height',
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
                            controller: bmi,
                            decoration: InputDecoration(
                              label:Text( 'BMI'),
                              hintText: 'BMI',
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
                            controller: bodyTemprature,
                            decoration: InputDecoration(
                              label:Text( 'Body Temprature'),
                              hintText: 'Body Temprature',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Heart Examination",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: heartRate,
                            decoration: InputDecoration(
                              label:Text( 'HeartRate (Pulse)'),
                              hintText: 'HeartRate (Pulse)',
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
                            controller: oxygenSaturation,
                            decoration: InputDecoration(
                              label:Text( 'Oxygen Saturation'),
                              hintText: 'Oxygen Saturation',
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
                            controller: respirationRate,
                            decoration: InputDecoration(
                              label:Text( 'Respiration Rate'),
                              hintText: 'Respitration Rate',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle:
                              TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Blood Pressure",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          SizedBox(
                            height:10,
                          ),
                          TextFormField(
                            controller: systolicBP,
                            decoration: InputDecoration(
                              label:Text( 'Systolic Blood Pressure'),
                              hintText: 'Systolic Blood Pressure',
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
                            controller: diastolicBP,
                            decoration: InputDecoration(
                              label:Text( 'Diastolic Blood Pressure'),
                              hintText: 'Diastolic Blood Pressure',
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
                          Text("Maternal Specific",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: glucoseLevel,
                            decoration: InputDecoration(
                              label:Text( 'Glucose level'),
                              hintText: 'Glucose level',
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
                            controller: gestationalAge,
                            decoration: InputDecoration(
                              label:Text( 'Gestational Age'),
                              hintText: 'Gestational Age',
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
                            controller: gravida,
                            decoration: InputDecoration(
                              label:Text( 'Gravida'),
                              hintText: 'Gravida',
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
                            controller: single_twin,
                            decoration: InputDecoration(
                              label:Text( 'Single/Twin'),
                              hintText: 'Single/Twin',
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
                            controller: miscarriage,
                            decoration: InputDecoration(
                              label:Text( 'Miscarriage'),
                              hintText: 'Miscarriage',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle: TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          // postFormOneData(
                          //     bodyWeight.text.toString(),bodyHeight.text.toString(),bmi.text.toString(),
                          //     bodyTemprature.text.toString(),heartRate.text.toString(),oxygenSaturation.text.toString(),
                          //     respirationRate.text.toString(),systolicBP.text.toString(),diastolicBP.text.toString(),
                          //     glucoseLevel.text.toString(),gestationalAge.text.toString(),gravida.text.toString(),single_twin.text.toString(),
                          //     miscarriage.text.toString()
                          // );
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
                                'Sign In',
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
}
