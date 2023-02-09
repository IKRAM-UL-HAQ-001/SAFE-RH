// // ignore_for_file: camel_case_types
//
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:path_provider_ex/path_provider_ex.dart';
class labsReports extends StatelessWidget {
  const labsReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
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
              "Labs Reports",
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
            //       const EdgeInsets.only(left: 1.0, right: 9.0, top: 10),
            //       icon: const Icon(
            //         Icons.notifications_none,
            //         size: 40,
            //       ),
            //       onPressed: () {}),
            // ),
          ],
        ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              child:const Text(
                "Under Construction"
                "\n"
                    "Data available when uploaded on server"
              )
            ),
          )
        ],
      ),
    );
  }
}
