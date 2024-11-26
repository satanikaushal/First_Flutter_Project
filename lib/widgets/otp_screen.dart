import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpScreenWidget extends StatefulWidget {
  var mobileNumber = "";

  OtpScreenWidget({super.key, required this.mobileNumber});

  @override
  State<OtpScreenWidget> createState() =>
      _OtpScreenWidgetState(mobileNumber: this.mobileNumber);
}

class _OtpScreenWidgetState extends State<OtpScreenWidget> {
  var mobileNumber = "";

  _OtpScreenWidgetState({required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter OTP", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.start),
        centerTitle: true
      ),
      floatingActionButton: Container(
        height: 55,
        width: 55,
        margin: EdgeInsets.all(10),
        child: IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next, size: 40, color: Colors.white,), style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.green.shade800),
        )),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Pinput(
              length: 4,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              isCursorAnimationEnabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
