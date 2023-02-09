// ignore_for_file: deprecated_member_use, unnecessary_null_comparison
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_rh/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessagesScreen extends StatefulWidget {
  final patientid;
  final appointid;
  MessagesScreen({
    this.patientid,
    this.appointid,
  });
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var loading = true;
  var lock = true;
  var appointId;
  var patientId;
  Timer? timer;
  bool showSpinner = false;

  File? filepath;

  File? image1;

  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      filepath = File(pickedFile.path);
      image1 = File(pickedFile.name);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Image.file(
                  File(filepath!.path).absolute,
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      uploadImage(filepath: '$filepath');
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                ]);
          });
    } else {
      print('no image selected');
    }
  }

  // void uploadImage(image) async {
  //   var keyUser;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   keyUser = sharedPreferences.getString('key');
  //   var keyUserID = sharedPreferences.getString('userId');
  //   var cookie = sharedPreferences.getString('cookie');
  //   print(keyUser);
  //   var data = {
  //     'appointId': "${widget.appointid}",
  //     'doctorId': "${widget.doctorid}",
  //     'patientId': "$keyUserID",
  //     'message': "",
  //     'attachment':'$image',
  //     "type": "1"
  //   };
  //   print(data);
  //   try {
  //     final url = Uri.parse("http://safe-rh-mis.com/messageDatapost/");
  //     var response = await http.post(
  //       url,
  //       body: data,
  //       headers: {"Cookie": "sessionid=$cookie"},
  //     );
  //     var data1=response.body;
  //     print("kkk $data1");
  //   }
  //   catch (e) {
  //     var a = e.toString();
  //     debugPrint(a);
  //   }
  // }

  @override
  Future<Map<String, dynamic>> uploadImage(
      {
      // required String userid,
      // required Report report,
      // required String incidentImagePath
      required String filepath}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var keyUserID = sharedPreferences.getString('userId');
      var cookie = sharedPreferences.getString('cookie');

      String fileName = filepath.split('/').last;
      print("111111111 $fileName");

      // var bytes = File(filepath).readAsBytesSync();
      // print("333333 $bytes");
      // String base64Image = base64Encode(bytes);
      // print("4444  $base64Image");
      var body = (
              // jsonEncode(
              {
        "doctorId": "$keyUserID",
        "patientId": "${widget.patientid}",
        "appointId": "${widget.appointid}",
        // "message":"",
        "attachment": "$filepath",
        "type": "1",
        // "full-name": report.fullName,
        // "location": report.location,
        // "description": report.description,
        // "profile-picture": report.profilePicture,
        // "longitude": report.longitude.toString(),
        // "latitude": report.latitude.toString(),
        // "file-name": fileName,
        // "incident-image": base64Image,
      }
          // print(body);
          );
      // print("55555 $body");
      final Url = "http://safe-rh-mis.com/messageDatapost/";
      // print("6666666");
      print(Url);
      var response = await Dio().post(
        // http.Response response = await http.post(
        Url,
        // + _addReport1_1,
        data: body,
        // body:body,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
          headers: {"Cookie": "sessionid=$cookie"},
        ),
      );
      // print("777777");
      print(response);
      // debugPrint("This is response from save report \n ${response.data}");
      if (response.data['success'] != null) {
        print("888888");
        return response.data;
      } else {
        print("999");
        return <String, dynamic>{"success": false};
      }
    } catch (error) {
      print("10101010");
      if (error is DioError) {
        print("12121212");
        debugPrint(
            "Error occured while saving data from the server!\nError:  ${error.response}");
      } else {
        print("1313131313131313");
        debugPrint(
            "Error occured while saving data from the server!\nError:  $error");
      }
      rethrow;
    }
  }

  Widget build(BuildContext context) {
    final textmsg = TextEditingController();
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const SizedBox(width: kDefaultPadding * 0.75),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("New Chat", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            actions: [
              // IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              SizedBox(
                width: kDefaultPadding / 2,
              )
            ],
          ),
        ),
        body: Column(children: [
          lock
              ? GestureDetector(
                  onTap: (() {
                    previousmessageDataget();
                  }),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text("Show previous Messages"),
                    ),
                  ),
                )
              : Text(''),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: sendrealdata.length,
                itemBuilder: (_, index) => Card(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      child: ListTile(
                        tileColor: Colors.white70,
                        title: (sendrealdata[index]["message"].length > 5)
                            ? sendrealdata[index]['message'][0] +
                                        sendrealdata[index]['message'][1] +
                                        sendrealdata[index]['message'][2] +
                                        sendrealdata[index]['message'][3] +
                                        sendrealdata[index]['message'][4] +
                                        sendrealdata[index]['message'][5] ==
                                    '/media'
                                ? Container(
                                    width: 700,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://safe-rh-mis.com' +
                                                sendrealdata[index]['message']),
                                      ),
                                    ),
                                  )
                                : Text(
                                    "${sendrealdata[index]['message']}",
                                    textAlign: sendrealdata[index]['id'] == 2
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )
                            : Text('${sendrealdata[index]['message']}',
                                textAlign: sendrealdata[index]['id'] == 2
                                    ? TextAlign.right
                                    : TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          "${sendrealdata[index]['time']}",
                          textAlign: sendrealdata[index]['id'] == 2
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 32,
                    offset: Offset(0, 4),
                    color: Color(0xff087949).withOpacity(0.3)),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 0.75),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textmsg,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type Message'),
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.attach_file),
                          //   color: Theme
                          //       .of(context)
                          //       .textTheme
                          //       .bodyText1
                          //       ?.color
                          //       ?.withOpacity(0.64),
                          //   onPressed: () {
                          //     getImage();
                          //   },
                          // ),
                          const SizedBox(width: kDefaultPadding / 4),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.color
                                ?.withOpacity(0.64),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.color
                                ?.withOpacity(0.64),
                            onPressed: () {
                              if (textmsg != '') {
                                messageDataPost(textmsg.text.toString(),
                                    appointId, patientId);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  var sendrealdata = [];
  var sendrealdata1 = [];
  var getpreviousdata = [];

  void initState() {
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => realmessageDataget());

    super.initState();
  }

  void messageDataPost(String textmsg, appointid, doctorid) async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);
    var data = {
      'appointId': "${widget.appointid}",
      'patientId': "${widget.patientid}",
      'doctorId': "$keyUserID",
      'message': "$textmsg",
      "type": "0"
    };
    try {
      final url = Uri.parse("http://safe-rh-mis.com/messageDatapost/");

      var response = await http.post(
        url,
        body: data,
        headers: {"Cookie": "sessionid=$cookie"},
      );
      // print( response.body);
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  void realmessageDataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var cookie = sharedPreferences.getString('cookie');
    Map data = {"appointId": "${widget.appointid}", "DocReal": ""};
    String body = json.encode(data);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/messageDataget/");
      print(url);
      var response = await http.post(url, body: body, headers: {
        "Cookie": "sessionid=$cookie",
      });
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          if (data[0].length > 1) {
            sendrealdata.add({
              "doctor": data[i]['doctor'],
              "time": data[i]['time'],
              "message": data[i]['message'],
              "id": data[i]['id'],
            });
            print(sendrealdata);
            if (this.mounted) {
              setState(() {
                loading = false;
              });
            }
          } else {
            sendrealdata1.add({
              "videourl": data[i]['videourl'],
            });
            if (sendrealdata1 != null) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(title: Text("Doctor Calling"), actions: [
                      TextButton(
                        onPressed: () {
                          var link = sendrealdata1[0]["videourl"];
                          print("link is $link");
                          var x = link.split("/").last;
                          print(x);
                          print(link);
                          // var x = 'https://';
                          // var url = x + link.toString();
                          print("url is $url");
                          JitsiMeetMethods().createMeeting(roomName: x);
                          // _launchURLBrowser(link.toString());
                          // print(sendrealdata1[0]["videourl"]);
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel")),
                    ]);
                  });
            }
          }
        }
      } else {
        print("dddd");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  _launchURLBrowser(String link) async {
    print(link);
    bool forceWebView = true;
    print("linkinfg");
    final Uri _url = Uri.parse('https://' + link);
    JitsiMeetMethods().createMeeting(roomName: _url.toString());
    // print('https://'+link);

    // if (!await launchUrl(_url)) {
    //   throw 'Could not launch $_url';
    // }
  }

  void previousmessageDataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    Map data = {
      "appointId": "${widget.appointid}",
      "patientId": "${widget.patientid}",
      'doctorId': "$keyUserID",
      "previous": ""
    };
    print("i ma previous $data");
    String body = json.encode(data);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/messageDataget/");
      print(url);
      var response = await http.post(url, body: body, headers: {
        "Cookie": "sessionid=$cookie",
      });
      print("i am h ");
      print(response.body);
      var data = jsonDecode(response.body);
      if (data.length != 0) {
        for (int i = 0; i < data.length; i++) {
          sendrealdata.insert(0, {
            "doctor": data[i]['doctor'],
            "time": data[i]['time'],
            "message": data[i]['message'],
            "id": data[i]['id']
          });
          print(
            "this $getpreviousdata",
          );
          setState(() {
            loading = false;
            lock = false;
          });
          return;
        }
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }
}

class JitsiMeetMethods {
  void createMeeting({
    required String roomName,
    // String username = '',
    // required BuildContext context,
    // required MatchingMethods methods
  }) async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
        FeatureFlagEnum.RAISE_HAND_ENABLED: false,
        FeatureFlagEnum.CHAT_ENABLED: false,
        FeatureFlagEnum.CALENDAR_ENABLED: false,
        FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
        FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
        FeatureFlagEnum.IOS_RECORDING_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
        FeatureFlagEnum.MEETING_NAME_ENABLED: false,
        FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
        FeatureFlagEnum.RECORDING_ENABLED: false,
        FeatureFlagEnum.TILE_VIEW_ENABLED: false,
      };

      var options = JitsiMeetingOptions(room: roomName);
      // ..userDisplayName = userInfo.name ?? "name"
      // ..userEmail = userInfo.email ?? "this@gmail.com"
      // ..userAvatarURL = userInfo.photoUrl ?? "123" // or .png
      // ..featureFlags = featureFlags;

      await JitsiMeet.joinMeeting(options, listener: JitsiMeetingListener(
        onConferenceTerminated: (message) {
          JitsiMeet.closeMeeting();
          //Moving the user back to home
          // methods.updateMeetingStatus(false);
          // Future.delayed(Duration(seconds: 5), () {
          //   methods.removeMeetingFromList();
          // });
          // methods.removeMeetingFromList();

          // Navigator.pushAndRemoveUntil<dynamic>(
          //   context, MaterialPageRoute<dynamic>(
          //     builder: (BuildContext context) => const StartMatching(),
          //   ),
          //       (route) => false, //if you want to disable back feature set to false
          // );
        },
      ));
      // Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      //   if (await methods.shouldEndMeeting() == 'end') {
      //     JitsiMeet.closeMeeting();
      //     //Moving the user back to home
      //     methods.removeMeetingFromList();
      //     Navigator.pushAndRemoveUntil<dynamic>(
      //       context,
      //       MaterialPageRoute<dynamic>(
      //         builder: (BuildContext context) => const StartMatching(),
      //       ),
      //       (route) => false, //if you want to disable back feature set to false
      //     );
      //     t.cancel();
      //   }
      // });
    } catch (error) {
      log("error: $error");
    }
  }
}
