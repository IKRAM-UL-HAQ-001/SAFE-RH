import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class categorySixForm extends StatefulWidget {
  final Id;
  final patientId;
  const categorySixForm({Key? key, this.Id,this.patientId});

  @override
  State<categorySixForm> createState() => _categorySixFormState();
}

class _categorySixFormState extends State<categorySixForm> {
  var loading = true;
  var totalLength;
  var splits=[];
  var finalDiagnosis;
  var HeartDisease;


  @override
  void initState() {
    attributeData();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController diagnosis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
                            clearIconProperty: IconProperty(
                                color: Colors.green),
                            searchDecoration: const InputDecoration(
                                hintText: "enter your custom hint text here"),

                            dropDownItemCount: splits.length,
                            dropDownList:
                            [
                              for(int x = 0; x < splits.length; x++)
                                DropDownValueModel(
                                    name: splits[x], value: "value${x + 1}"),
                            ],
                            onChanged: (value) {
                              finalDiagnosis = value;
                              print(finalDiagnosis.toString());
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: diagnosis,
                            decoration: InputDecoration(
                              label: Text('New Problem'),
                              hintText: 'New Problem   '
                                  '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                BorderSide(color: Colors.white),
                              ),
                              hintStyle: TextStyle(color: Color(0xff8391A1)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropDownTextField(
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
                            clearIconProperty: IconProperty(
                                color: Colors.green),
                            searchDecoration: const InputDecoration(
                                hintText: "enter your custom hint text here"),

                            dropDownItemCount: 2,
                            dropDownList: const
                            [
                              DropDownValueModel(name: "Yes", value: "value1"),
                              DropDownValueModel(name: "No", value: "value1"),
                            ],
                            onChanged: (value) {
                              HeartDisease = value;
                              print(HeartDisease.toString());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          postFormSevenData(
                              diagnosis.text.toString(), finalDiagnosis,HeartDisease);
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

  void postFormSevenData(String diagnosis, finalDiagnosis,HeartDisease) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = await sharedPreferences.getString('userId');
    var keyUser = sharedPreferences.getString('key');
    Map data = {
      "key": "$keyUser",
      "category": "6",
      "patientId":"${widget.patientId}",
      "addedBy":"userid",
      "data": {
        "previousdisease": "$finalDiagnosis",
        "NewProblems": "$diagnosis",
        "HeartDiseasePH":"$HeartDisease"
      }
    };
    print("data is $data");
    String body = json.encode(data);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/DynamicformsSave/");
      Response response = await http.post(url, body: body, headers: {
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
      var a = e.toString();
      debugPrint(a);
    }
  }

  void attributeData() async {
    try {
      var url = Uri.parse("https://safe-rh-mis.com/AttributeList/6");
      print(url);
      Response response = await http.get(
        url,
      );
      var data = jsonDecode(response.body);

      var a = "${data[0]['options']}";
      print(a);
      var singleline = a.replaceAll("\n", '');
      List<String> x = singleline.split(",");
      totalLength = x.length;
      print(totalLength);
      for (int i = 0; i < totalLength; i++) {
        if (x[i] == '') {}
        else {
          splits.add(x[i]);
          print(splits);
        }
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

}