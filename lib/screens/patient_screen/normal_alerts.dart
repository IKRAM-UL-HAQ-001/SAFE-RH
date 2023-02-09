// // ignore_for_file: camel_case_types
//
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class normalAlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
            "Maternal Feelings",
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
          //       padding: const EdgeInsets.only(left: 1.0, right: 9.0, top: 10),
          //       icon: const Icon(
          //         Icons.notifications_none,
          //         size: 40,
          //       ),
          //       onPressed: () {}),
          // ),
        ],
      ),
        body: SafeArea(
            child : Center(
              child:DynamicallyCheckbox(),
            )
        ),
    );
  }
}

class DynamicallyCheckbox extends StatefulWidget {
  @override



  
  DynamicallyCheckboxState createState() => new DynamicallyCheckboxState();
}

class DynamicallyCheckboxState extends State {

  Map<String, bool> List = {
    'Pain under Ribs' : false,
    'Headache' : false,
    'Bleeding' : false,
    'vision Blur' : false,
    'Pain in Uterus' : false,
  };

  var holder_1 = [];

  getItems(){
    List.forEach((key, value) {
      if(value == true)
      {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[
      // RaisedButton(
      //   child: Text(" Get Checked Checkbox Values "),
      //   onPressed: getItems,
      //   color: Colors.pink,
      //   textColor: Colors.white,
      //   splashColor: Colors.grey,
      //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      // ),

      Expanded(
        child :
        ListView(
          children: List.keys.map((String key) {
            return  CheckboxListTile(
              title:  Text(key),
              value: List[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool? value) {  },
              // onChanged: (bool value) {
              //   setState(() {
              //     // List[key] = value;
              //   }
              //     );
              // },
            );
          }).toList(),
        ),
      ),]);
  }
}

