// String dropdownValue = list.first;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../src/Widget/list.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class tempratureDetailPage extends StatefulWidget {
  const tempratureDetailPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _tempratureDetailPageState createState() => _tempratureDetailPageState();
}

class _tempratureDetailPageState extends State<tempratureDetailPage> {
  var loading = true;
  var showTable = false;
  String name = '2022-07-18:19';
  String change = 'hour';
  List<SalesData> data = [];
  var listAll = [];
  void getAll() async {
    var keyUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    keyUser = sharedPreferences.getString('key');
    var keyUserID = sharedPreferences.getString('userId');
    var cookie = sharedPreferences.getString('cookie');
    print(keyUser);

    Map data = {
      "key": "$keyUser",
      "patientId": "$keyUserID",
      "uploaded": "",
    };
    String body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse("https://safe-rh-mis.com/vitals/$keyUserID/1");
      print(url);
      Response response = await http.get(
        url,
      );
      print("idr h ");
      // log(response.body);
      var data = jsonDecode(response.body);
      // print("${data}");
      //
      print(data.length);
      if (data.length != 1) {
        print('bb');
        var datee;
        for (int i = 0; i < data.length; i++) {
          datee = data[i]['data'];

          listAll.add({
            "date": data[i]['date'],
            "name": data[i]['Name'],
            "value": data[i]['value'],
            "id": data[i]['testId'],
            "nam": data[i]['nam'],
            "upload": data[i]['uploadTime']
          });
        }
        print(
          "this $listAll",
        );

        setState(() {
          hour();
          loading = false;
        });

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DateScreen(slots: slots,date: datee,docid: docId,)));

        return;
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "No Data available ");
        // 3740607766041
        print("ye chota h ");
      }
    } catch (e) {
      var a = e.toString();
      debugPrint(a);
    }
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'S',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff09A9B9)),
          children: [
            TextSpan(
              text: 'AFE',
              style: TextStyle(color: Color(0xff09A9B9), fontSize: 30),
            ),
            TextSpan(
              text: '-RH',
              style: TextStyle(color: Color(0xff09A9B9), fontSize: 30),
            ),
          ]),
    );
  }

  double value = 0.0;

  //var for one day
  void day() {
    // name = listAll[listAll.length]['date'];
    print(listAll[listAll.length - 1]['date']);
    print(listAll.length);
    var length = listAll.length - 1;
    listAll.forEach(
      (element) => {
        if (element['date'] == listAll[listAll.length - 1]['date'])
          {
            // print(element['upload'][0] + element['upload'][1]),
            // print(element['upload']),

            value = double.parse(element['value']),
            //for specif hour
            // if (element['upload'][0] + element['upload'][1] == '19')
            // if (element['upload'][0] + element['upload'][1] == '19')
            //   {
            data.add(SalesData(
                element['upload'][0] +
                    element['upload'][1] +
                    element['upload'][2] +
                    element['upload'][3] +
                    element['upload'][4] +
                    element['upload'][5] +
                    element['upload'][6] +
                    element['upload'][7] +
                    element['upload'][8],
                value))
            // }
          }
        else
          {
            // list.add(element['date']), incremt += 1, date = element['date']
          }
      },
    );
  }

  void hour() {
    print('inside hour');
    print(listAll.length);
    listAll.forEach(
      (element) => {
        if (element['date'] == listAll[listAll.length - 1]['date'])
          {
            // print(element['upload'][0] + element['upload'][1]),
            // print(element['upload']),

            value = double.parse(element['value']),
            //for specif hour
            // if (element['upload'][0] + element['upload'][1] == '19')
            if (element['upload'][0] + element['upload'][1] ==
                listAll[listAll.length - 1]['upload'][0] +
                    listAll[listAll.length - 1]['upload'][1])
              {
                data.add(SalesData(
                    element['upload'][0] +
                        element['upload'][1] +
                        element['upload'][2] +
                        element['upload'][3] +
                        element['upload'][4] +
                        element['upload'][5] +
                        element['upload'][6] +
                        element['upload'][7] +
                        element['upload'][8],
                    value))
              }
          }
        else
          {
            // list.add(element['date']), incremt += 1, date = element['date']
          }
      },
    );
  }

  void month() {
    print('inside hour');
    print(listAll.length);
    listAll.forEach(
      (element) => {
        print(element['date'][0] +
            element['date'][1] +
            element['date'][2] +
            element['date'][3] +
            element['date'][4] +
            element['date'][5] +
            element['date'][6]),
        if ('2022-07' ==
            element['date'][0] +
                element['date'][1] +
                element['date'][2] +
                element['date'][3] +
                element['date'][4] +
                element['date'][5] +
                element['date'][6])
          {
            // print(element['upload'][0] + element['upload'][1]),
            // print(element['upload']),

            value = double.parse(element['value']),
            //for specif hour
            // if (element['upload'][0] + element['upload'][1] == '19')

            data.add(SalesData(
                element['upload'][0] +
                    element['upload'][1] +
                    element['upload'][2] +
                    element['upload'][3] +
                    element['upload'][4] +
                    element['upload'][5] +
                    element['upload'][6] +
                    element['upload'][7] +
                    element['upload'][8],
                value))
          }
        else
          {
            // list.add(element['date']), incremt += 1, date = element['date']
          }
      },
    );
  }

  final List<dynamic> coffeType = [
    ['Hour', false],
    ['Day', false],
    ['Details', false]
  ];

  void TappingEffect(int index) {
    setState(() {
      if (coffeType[index][1] == false) {
        // print(coffeType[index][1]);
        for (int x = 0; x < coffeType.length; x++) {
          data = [];
          coffeType[x][1] = false;
          showTable = false;
        }
        coffeType[index][1] = true;
        if (coffeType[index][0] == 'Day') {
          name = listAll[listAll.length - 1]['date'];
          day();
        }
        if (coffeType[index][0] == 'Hour') {
          name = listAll[listAll.length - 1]['date'] +
              ':' +
              listAll[listAll.length - 1]['upload'][0] +
              listAll[listAll.length - 1]['upload'][1];
          hour();
        }
        if (coffeType[index][0] == 'Details') {
          showTable = true;
        }
      } else {
        data = [];
        coffeType[index][1] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          foregroundColor: const Color(0xff09a9b9),
          backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
          title: const Center(
            child: Text(
              "Temprature",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff09a9b9)),
            ),
          ),
        ),
      ),
      // awais for graph  by dr tassawar groupedby date

      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 20),
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coffeType.length,
                        itemBuilder: (context, index) {
                          return CoffeType(
                            coffeType: coffeType[index][0],
                            selected: coffeType[index][1],
                            onTap: () {
                              TappingEffect(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  showTable
                      ? DataTable(
                          sortColumnIndex: 0,
                          sortAscending: true,
                          columns: [
                              DataColumn(label: Text('Date')),
                              DataColumn(
                                label: Text('Value'),
                                numeric: true,
                              )
                            ],
                          rows: [
                              for (int x = 0; x < listAll.length; x++)
                                DataRow(
                                    // selected: true,
                                    cells: [
                                      DataCell(Text(listAll[x]['date'])),
                                      DataCell(Text(listAll[x]['value']))
                                    ]),
                            ])
                      : Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 550,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                title: ChartTitle(
                                    text: 'Health Statistics',
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                legend: Legend(
                                  isVisible: true,
                                ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ChartSeries<SalesData, String>>[
                                  LineSeries<SalesData, String>(
                                    dataSource: data,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.month,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales,
                                    name: 'Temp',
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: false),
                                  ),
                                ],
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Column(
                            //       children: [
                            //         Container(
                            //           height: 40,
                            //           width: 40,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(50),
                            //               color: Colors.orange),
                            //           child: Center(
                            //               child: Text(
                            //             '185',
                            //             style: TextStyle(color: Colors.white),
                            //           )),
                            //         ),
                            //         Text('Maximum')
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       width: 40,
                            //     ),
                            //     Column(
                            //       children: [
                            //         Container(
                            //           height: 40,
                            //           width: 40,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(50),
                            //               color: Colors.orange),
                            //           child: Center(
                            //               child: Text(
                            //             '83',
                            //             style: TextStyle(color: Colors.white),
                            //           )),
                            //         ),
                            //         Text('Average')
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       width: 40,
                            //     ),
                            //     Column(
                            //       children: [
                            //         Container(
                            //           height: 40,
                            //           width: 40,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(50),
                            //               color: Colors.orange),
                            //           child: Center(
                            //             child: Text(
                            //               '0',
                            //               style: TextStyle(color: Colors.white),
                            //             ),
                            //           ),
                            //         ),
                            //         Text('Minimum')
                            //       ],
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                ],
              ),
            ),
    );

    // body: ListView.builder(
    //   itemCount: incremt,
    //   itemBuilder: (_, index) => Card(
    //     margin: const EdgeInsets.all(10),
    //     child: InkWell(
    //       onTap: () async {
    //         // jo[index]['id'];
    //         // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    //         //
    //         // sharedPreferences.setString('userId', jo[index]['id'].toString());
    //         // login(widget.slots[index]);
    //       },
    //       child: ExpansionTile(
    //         title: Text(
    //           list[index],
    //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    //         ),
    //         children: <Widget>[
    //           // ListTile(
    //           //   title: Text(
    //           //     "Name: ${listAll[index]["name"]}",
    //           //     style: TextStyle(fontWeight: FontWeight.w700),
    //           //   ),
    //           // ),
    //           for (int x = 0; x < 2;x++)
    //             ListTile(
    //               title: Text(
    //                 "value: ${listAll[index]["value"]}",
    //                 style: TextStyle(fontWeight: FontWeight.w700),
    //               ),
    //             ),

    //           // ListTile(
    //           //   title: Text(
    //           //     "nam: ${listAll[index]["nam"]}",
    //           //     style: TextStyle(fontWeight: FontWeight.w700),
    //           //   ),
    //           // ),
    //           // ListTile(
    //           //   title: Text(
    //           //     "UploadTime: ${listAll[index]["upload"]}",
    //           //     style: TextStyle(fontWeight: FontWeight.w700),
    //           //   ),
    //           // )
    //         ],
    //       ),
    //     ),
    //   ),
    // ), //b
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}
