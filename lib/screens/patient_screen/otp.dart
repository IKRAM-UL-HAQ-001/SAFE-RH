import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  FlutterOtp otp = FlutterOtp();

  String phoneNumber = "93XXXXXXXX"; //enter your 10 digit number
  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode ="+92"; // give your country code if not it will take +1 as default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Center(
            child: ElevatedButton(
              child: Text("Send"),
              onPressed: () {
                // call sentOtp function and pass the parameters

                otp.sendOtp("3174144713", 'OTP is : pass the generated otp here ',
                    minNumber, maxNumber, countryCode);
             //   bool isCorrectOTP = resultChecker();


              },
            )),
      ),
    );
  }
}
