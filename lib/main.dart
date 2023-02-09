import 'package:flutter/material.dart';
import 'package:safe_rh/src/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class  MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'SAFE-RH',
      theme: ThemeData(
        primarySwatch:Colors.blue,
        // primarySwatch: Color(0xff09a9b9),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:const WelcomePage(),

    );
  }
}
