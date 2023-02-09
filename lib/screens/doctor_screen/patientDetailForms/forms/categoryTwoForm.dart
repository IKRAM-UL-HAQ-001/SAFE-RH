// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class categoryTwoForm extends StatefulWidget {

  final Id;
  final patientId;
  const categoryTwoForm({Key? key, this.Id,this.patientId});

  @override
  State<categoryTwoForm> createState() => _categoryTwoFormState();
}

class _categoryTwoFormState extends State<categoryTwoForm> {
//   List<Map> availableHobbies = [
//     {"name": "Foobball", "isChecked": false},
//     {"name": "Baseball", "isChecked": false},
//     {
//       "name": "Video Games",
//       "isChecked": false,
//     },
//     {"name": "Readding Books", "isChecked": false},
//     {"name": "Surfling The Internet", "isChecked": false}
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body:
//       SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child:
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             const Text(
//               'Choose your hobbies:',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//
//             // The checkboxes will be here
//             Column(
//                 children: availableHobbies.map((hobby) {
//                   return CheckboxListTile(
//                       value: hobby["isChecked"],
//                       title: Text(hobby["name"]),
//                       onChanged: (newValue) {
//                         setState(() {
//                           hobby["isChecked"] = newValue;
//                         });
//                       });
//                 }).toList()),
//
//             // Display the result here
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//             Wrap(
//               children: availableHobbies.map((hobby) {
//                 if (hobby["isChecked"] == true) {
//                   return Card(
//                     elevation: 3,
//                     color: Colors.amber,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(hobby["name"]),
//                     ),
//                   );
//                 }
//                 return Container();
//               }).toList(),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

  var loading=true;
  var splits=[];
  var a=[];
  var b;
  var data=[];
  var splitsAttribute=[];
  var totalLength;
  var totalAttributeLength;
  var x;
  var singleline;
  var getAttributeList=[];
  final String name="";
  bool isSelected=false;

   void initState() {
     attributeData();
      // TODO: implement initState
      super.initState();
   }
    List<Map> availableHobbies = [];
    // List<Map> a = [];
    List<Map> availableAttributeHobbies = [];
  final List<String> _items = ['item1', 'item2', 'item3'];
  final List<String> _itemsAttribute = ['item1', 'item2', 'item3'];
  List<String> _selectedItems = [];
  List<String> _selectedAttributeItems = [];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Expansion Tile'
        ),
      ),
      body:loading
          ? Center(child: CircularProgressIndicator())
      :SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              for(int x=0; x<totalLength;x++)
              ExpansionTile(
                onExpansionChanged: (bool expanding) => attributeChildData(splits[x]),
                title: Text(
                  "${splits[x]}",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                children: <Widget>[
                  Column(
                      children: availableAttributeHobbies.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                  // for(int y=0; y<totalAttributeLength;y++)
                  // ExpansionTile(
                  //   title: Text(
                  //     "${splitsAttribute[y]}",
                  //   ),
                    // children: <Widget>[
                    //   ListTile(
                    //     title: Text("${splitsAttribute[y]}"),
                    //   )
                    // ],
                  // ),
                  // ListTile(
                  //   onTap:(){
                  //     setState(() {
                  // attributeData();
                  //     });
                  //   },
                    // title: Text(
                    //     '${splits[x]}'
                    // ),
                  // )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
  // Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //     backgroundColor: Color.fromRGBO(235, 241, 245, 1),
  //     body: loading
  //     ? Center(child: CircularProgressIndicator())
  //     : SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child:
  //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //           const Text(
  //             'Choose your hobbies:',
  //             style: TextStyle(fontSize: 24),
  //           ),
  //           const SizedBox(height: 10),
  //           const Divider(),
  //           const SizedBox(height: 10),
  //
  //           // The checkboxes will be here
  //           Column(
  //               children: availableHobbies.map((hobby) {
  //                 return CheckboxListTile(
  //                     value: hobby["isChecked"],
  //                     title: Text(hobby["name"]),
  //                     onChanged: (newValue) {
  //                       setState(() {
  //                         hobby["isChecked"] = newValue;
  //                       });
  //                     });
  //               }).toList()),
  //
  //           // Display the result here
  //           const SizedBox(height: 10),
  //           const Divider(),
  //           const SizedBox(height: 10),
  //           Wrap(
  //             children: availableHobbies.map((hobby) {
  //               if (hobby["isChecked"] == true) {
  //                 return Card(
  //                   elevation: 3,
  //                   color: Colors.amber,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(hobby["name"]),
  //                   ),
  //                 );
  //               }
  //               return Container();
  //             }).toList(),
  //           )
  //         ]),
  //       ),
  //     ),
  //   );
  // }
 void attributeData() async {

   try {
     var url = Uri.parse("https://safe-rh-mis.com/AttributeList/2");
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
         print(">>>>>:");
         print(x[i]);
         availableHobbies.add({'name':x[i], "isChecked": false});
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

 void attributeChildData(childName)async{
   availableAttributeHobbies=[];
    try {
      var url = Uri.parse("https://safe-rh-mis.com/ScreeningList/${childName}");
      print(url);
      Response response = await http.get(url);
      var data = jsonDecode(response.body);
      print(".............");
      print(data.length);
      print(".............");

      for(var p=0; p<data.length;p++) {
        data[p] = data[p]['options'];
        print("${p} ${data[p]}");
        List<String> x = data[p].split(",");
        print("${x} ");
        for(int i=0; i<x.length; i++){
          if(x[i]==''){
          }
          else{
            print(">>>>>:");
            print(x[i]);
            availableAttributeHobbies.add({'name':x[i], "isChecked": false});
            splitsAttribute.add(x[i]);
            print(splitsAttribute);
          }
        }

        // getAttributeList[p]=x;
        // print("b ${getAttributeList[p]}");
        // totalAttributeLength = getAttributeList[p].length;
        // print(totalAttributeLength);
        // List<String> x = data[p].split(",");
        // totalAttributeLength = x.length;
        // print(totalAttributeLength);
      // }
      //   for(int i=0; i<totalAttributeLength; i++){
      //     print("last");
      //       if(x[i]==''){
      //       print("i m if");
      //       }
      //       else{
      //         print(">>>>>:");
      //           print(x[i]);
      //             availableAttributeHobbies.add({'name':x[i], "isChecked": false});
      //             splitsAttribute.add(x[i]);
      //           print(splitsAttribute);
      //         print(">>>>>:");
      //       }
      //   }
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
