// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:safe_rh/screens/patient_screen/bhuhistory.dart';
import 'package:safe_rh/screens/patient_screen/navbar.dart';
import 'package:safe_rh/widgets/card_main.dart';

class bhuDataScreen extends StatefulWidget {
  const bhuDataScreen({Key? key}) : super(key: key);

  @override
  State<bhuDataScreen> createState() => _bhuDataScreen();
}

class _bhuDataScreen extends State<bhuDataScreen> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;
    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
      drawer: const sideBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          ),
          foregroundColor: const Color(0xff09a9b9),
          backgroundColor: const Color.fromRGBO(242, 243, 245, 15),
          title: const Center(
            child: Text(
              "Maternal DashBoard",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff09a9b9)),
            ),
          ),
          actions: [
            // Badge(
            //   position: BadgePosition.topEnd(top: 10, end: 10),
            //   badgeContent: const Text(
            //     '9',
            //     style: TextStyle(color: Colors.white, height: 1, fontSize: 10),
            //   ),
            //   child: IconButton(
            //       padding:
            //           const EdgeInsets.only(left: 1.0, right: 9.0, top: 10),
            //       icon: const Icon(
            //         Icons.notifications_none,
            //         size: 40,
            //       ),
            //       onPressed: () {}),
            // ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 50),
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return const CardMain(
                            image: AssetImage('images/icons/hb.png'),
                            title: "Heart Beat",
                            value: "96",
                            unit: "bpm",
                            color: Colors.lightBlueAccent,
                          );
                        case 1:
                          return const CardMain(
                            image: AssetImage('images/icons/temp.png'),
                            title: "Temperature",
                            value: "97",
                            unit: "F",
                            color: Colors.lightGreen,
                          );
                        case 2:
                          return const CardMain(
                            title: "SpO2",
                            value: "98",
                            unit: "%",
                            color: Colors.limeAccent,
                            image: AssetImage("images/icons/spo2.png"),
                          );
                        case 3:
                          return const CardMain(
                            title: "Blood \n Pressure",
                            value: "80/120",
                            unit: "mmHg",
                            color: Colors.cyanAccent,
                            image: AssetImage("images/icons/bp.png"),
                            // width:50,
                            // width:50,
                          );
                        default:
                          return const CardMain(
                            title: "Rest",
                            value: "76",
                            unit: "avg bpm",
                            image: AssetImage("images/icons/Battery.png"),
                            color: Colors.deepOrangeAccent,
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const bhuHistory(),),);
        },
        label: const Text('History'),
        icon: const Icon(Icons.history),
        backgroundColor: const Color(0xff09a9b9),
      ),
    );
  }
}
