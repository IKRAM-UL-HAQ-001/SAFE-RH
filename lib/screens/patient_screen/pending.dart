// // ignore_for_file: unnecessary_import, unnecessary_null_comparison
// // import 'dart:html';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart'as http;
// import 'package:http_parser/http_parser.dart';
//
// class PendingFiles extends StatefulWidget {
//   const PendingFiles({Key? key}) : super(key: key);
//
//   @override
//   State<PendingFiles> createState() => _PendingFilesState();
// }
//
// class _PendingFilesState extends State<PendingFiles> {
//   Dio dio= new Dio();
//   var image;
//   var listAll=[];
//   void getAll()async{
//     var keyUser;
//     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
//     keyUser=sharedPreferences.getString('key');
//     var keyUserID=sharedPreferences.getString('userId');
//     var cookie=sharedPreferences.getString('cookie');
//
//     Map data = {
//       "key": "$keyUser",
//       "patientId": "$keyUserID",
//       "pending": "",
//     };
//     String body = json.encode(data);
//     try {
//       var url = Uri.parse("https://safe-rh-mis.com/labtest_api/");
//       var response = await http.post(
//         url,
//         body: body,
//         headers: {
//           "Cookie":"sessionid=$cookie",
//           'Content-Type': 'application/json'
//         },
//       );
//       var data = jsonDecode(response.body);
//       if(data.length!=0){
//         for(int i=0;i<data.length;i++){
//           listAll.add({"date":data[i]['date'],"name":data[i]['name'],"doctor":data[i]['prescribedBy'],"id":data[i]['testId']});
//         }
//         setState(() {
//         });
//         return;
//       }
//       else{
//         Fluttertoast.showToast(msg:"No Reports available ");
//       }
//     }
//     catch(e){
//       var a = e.toString();
//       debugPrint(a);
//     }
//   }
//   void getFileUpload(id,path) async {
//     // var filename= split(path).last;
//     // print("file name is $filename");
//   print("id is $id");
//   print("path is $path");
//     try {
//       FormData formData = new FormData.fromMap({
//         "testNo": "$id",
//         "choose": "",
//         // "file": await MultipartFile.fromFile(path,filename: filename)
//       });
//       print(formData);
//       // var url= Uri.parse("https://safe-rh-mis.com/labtest_api/");
//       // var request = new http.MultipartRequest("POST", url);
//       // request.fields['choose'] = '';
//       // request.fields['testNo'] = '$id';
//       // request.files['file']='$filename' as http.MultipartFile;
//       // request.files.add(new http.MultipartFile.fromBytes
//       //   ('file',await File fromUri("/media/"+filename).readAsBytes()));
//       // var response = await Dio().post("https://safe-rh-mis.com/labtest_api/",data: formData);
//       // print("File upload response: $request");
//       // print(request.data['message']);
//     } catch (e) {
//       print("expectation Caugch: $e");
//     }
//   }
// //   getFileUpload(path, dynamic file,) async {
// //     var filename=path.split().last;
// //     print(filename);
// //     var body = {
// //
// //       "file":"$filename",
// //       "testNo":"874",
// //       "choose":"",
// //     };
// //     try {
// //       final res = await postMultipart( "https://safe-rh-mis.com/labtest_api/", body, file );
// //       if( res=="done" ) {
// //         // fetchProjectFiles();
// //         print( "File Uploaded!, done" );
// //         // userInfoData2();
// //       } else if (res == "full") {
// //         print( "You exceeded your storage limit, error" );
// //       } else {
// //         print("Technical Error");
// //       }
// //     }
// //     // on InternetException {
// //     //   return "internet";
// // //    }
// //     catch( error ) {
// //       return "error";
// //     }
// //   }
//   @override
//   void initState() {
//
//     getAll();
//
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldstate,
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text("Upload Files",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.white,automaticallyImplyLeading: false,),
//       body: ListTileTheme(
//         contentPadding: const EdgeInsets.all(15),
//         iconColor: Colors.red,
//         textColor: Colors.black,
//         tileColor:Colors.grey.shade200,
//         style: ListTileStyle.list,
//         dense: true,
//         child: ListView.builder(
//           itemCount:listAll.length,
//           itemBuilder: (_, index) => Card(
//             margin: const EdgeInsets.all(10),
//             child: InkWell(
//               onTap: ()async{
//               },
//               child: ListTile(
//                 trailing: InkWell(
//                     onTap: ()async
//                     {
//                       // File imagefile;
//                       // ImagePicker picker = ImagePicker();
//                       // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                       // if(picker!=null){
//                       //   setState(() {
//                       //     image=picker as File;
//                       //   });
//                       // }
//                       // try{
//                       //   String filename=image.path.split('/').last;
//                       //   FormData formData = new FormData.fromMap(
//                       //   {
//                       //     "testNo":"874",
//                       //     "choose":"",
//                       //     "file": await MultipartFile.fromFile(image.path,filename:filename,
//                       //   contentType: MediaType('image','jpg')),
//                       //     'type':'image/jpg'
//                       //   });
//                       //   print("aaa");
//                       //   Response response= await dio.post("https://safe-rh-mis.com/labtest_api/",data: formData,
//                       //   options: Options(
//                       //     headers: {
//                       //       "accept":"*/*",
//                       //       'content-Type':"multipart/form-data"
//                       //     }
//                       //   ));
//                       //   print("cccc ${response.data}");
//                       // }
//                       // catch(e){
//                       //   print(e);
//                       // }
//
//                       FilePickerResult? result =
//                       await FilePicker.platform.pickFiles();
//
//                       print(result?.paths[0]);
//                       print("kiikiki");
//                       getFileUpload(listAll[index]['id'], "${result?.paths[0]}");
//                       // getFileUpload(result?.paths[0]);
//                     },
//                     child: Icon(Icons.upload_file)),
//                 title: Text("${listAll[index]['name']}",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)),
//                 subtitle: Text("Prescribed By: ${listAll[index]['doctor']}",style: TextStyle(color: Colors.black,fontSize: 16.0)),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // Future<dynamic> postMultipart(
// //     String url, Map<String, String> body, dynamic filenam) async {
// //   var headers = {
// //     // 'Accept': 'application/json'
// //   };
// //   print(filenam.toString());
// //   try {
// //     var request = http.MultipartRequest('POST', Uri.parse('$url'));
// //     request.files
// //         .add(await http.MultipartFile.fromPath('file', filenam.toString()));
// //     request.fields.addAll(body);
// //     // request.headers.addAll(headers);
// //     http.StreamedResponse response = await request.send();
// //
// //     if (response.statusCode == 200) {
// //       response.stream.transform(utf8.decoder).listen((value) {
// //         print(value);
// //       });
// //       return "done";
// //     } else if (response.statusCode == 302) {
// //       print("full");
// //       print("Error in marking read !");
// //       return "full";
// //     } else {
// //       response.stream.transform(utf8.decoder).listen((value) {
// //         print(value);
// //       });
// //       print("Error in marking read !" );
// //       return "error";
// //     }
// //   } catch (err) {
// //     if( err.toString().contains( 'Failed host lookup' ) ) {
// //       // throw InternetException( 'internet' );
// //     }
// //     print("Catch Error" + err.toString() );
// //   }
// // }

// ignore_for_file: unnecessary_import, unused_local_variable, override_on_non_overriding_member
// import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

class PendingFiles extends StatefulWidget {
  const PendingFiles({Key? key}) : super(key: key);

  @override
  State<PendingFiles> createState() => _PendingFilesState();
}

class _PendingFilesState extends State<PendingFiles> {
  var listAll = [];

  void getAll() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');

    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "pending": "",
    };
    String body = json.encode(data);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/labtest_api/");
      var response = await http.post(
        url,
        body: body,
        headers: {"Cookie": "sessionid=$cookie", 'Content-Type': '*/*'},
      );
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          listAll.add({
            "date": data[i]['date'],
            "name": data[i]['name'],
            "doctor": data[i]['prescribedBy'],
            "id": data[i]['testId']
          });
        }
        setState(() {});

        return;
      } else {
        Fluttertoast.showToast(msg: "No Reports available ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void getFileUpload(id, path) async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    try {
      final httpDio = Dio();
      var data = FormData.fromMap({
        "key": "$keyUser",
        "testNo": "$id",
        "choose": "",

      });
      data.files.add(MapEntry(
          "file",
          await MultipartFile.fromFile(path,
              filename: path.toString().split("/").last)));
      var response = await httpDio
          .post("https://safe-rh-mis.com/labtest_api/", data: data);
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Upload Files",
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.red,
        textColor: Colors.black,
        tileColor: Colors.grey.shade200,
        style: ListTileStyle.list,
        dense: true,
        child: ListView.builder(
          itemCount: listAll.length,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {},
              child: ListTile(
                trailing: InkWell(
                    onTap: () async {
                      print('GPKG');
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      print(result?.paths[0]);
                      getFileUpload(
                          listAll[index]['id'], "${result?.paths[0]}");
                      // getFileUpload(listAll[index]['id']);
                    },
                    child: Icon(Icons.upload_file)),
                title: Text("${listAll[index]['name']}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                subtitle: Text("Prescribed By: ${listAll[index]['doctor']}",
                    style: TextStyle(color: Colors.black, fontSize: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
