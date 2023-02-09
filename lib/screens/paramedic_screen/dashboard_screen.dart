import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:safe_rh/screens/paramedic_screen/home.dart';
import 'package:safe_rh/screens/paramedic_screen/profile.dart';
import 'package:safe_rh/screens/paramedic_screen/schedule.dart';

class paramedicDashBoardScreen extends StatefulWidget {
  @override
  State<paramedicDashBoardScreen> createState() => _paramedicDashBoardScreenState();
}

class _paramedicDashBoardScreenState extends State<paramedicDashBoardScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Center(child: Text("0")),
    Center(child: Text("1")),
    Center(child: Text("2")),
    Center(child: Text("3")),
    Center(child: Text("4"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 241, 245, 1),
      body: buildBody(),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.event),
            title: Text('Statistics'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.highlight),
            title: Text('Appoit'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    if (_selectedIndex == 0) {
      return Home();
    } else if (_selectedIndex == 1) {
      return Scedule();
    }
    // else if (_selectedIndex == 2) {
    //   return categoryListDetail();
    // }
    else {
      return DoctorProfile();
    }
  }
}
