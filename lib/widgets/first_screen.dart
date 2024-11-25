import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widgets/otp_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreenWidget extends StatefulWidget {
  FirstScreenWidget({super.key});

  @override
  State<FirstScreenWidget> createState() => _FirstScreenWidgetState();
}

class _FirstScreenWidgetState extends State<FirstScreenWidget> {
  var mobileNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600, minHeight: 400, maxHeight: double.infinity,),
          color: Colors.white,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/my_bg_image.png",
                        width:
                        (MediaQuery
                            .of(context)
                            .size
                            .width
                            .clamp(0, 600)) *
                            0.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Welcome to Naariyal Paniwala",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.green.shade700),
                      ),
                      Text(
                        "Har Roz Naariyal Pani Aapke Ghar",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green.shade700, width: 2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green.shade700, width: 2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade700
                                      .withAlpha((255 * 0.3).toInt()),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              margin: EdgeInsets.only(right: 10),
                              child: Center(
                                child: Text(
                                  "+91",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey.shade800,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: Colors.grey),
                            counterText: "",
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade900),
                          onChanged: (value) {
                            setState(() {
                              mobileNumber = value;
                            });
                          },
                          autofocus: false,
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (mobileNumber.length != 10) {
                              Fluttertoast.showToast(msg: "Invalid number");
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (
                                    context) => OtpScreenWidget(mobileNumber: mobileNumber,)),
                              );
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              WidgetStatePropertyAll(Colors.green.shade700),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)))),
                          child: Text(
                            "Get OTP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            height: 1.4),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'By continuing, I accept the ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // todo
                              },
                            text: 'Privacy Policy',
                            style: TextStyle(
                                color: Colors.green.shade700,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // todo
                              },
                            text: 'Terms and Conditions.',
                            style: TextStyle(
                                color: Colors.green.shade700,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
