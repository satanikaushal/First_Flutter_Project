import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widgets/otp_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_number_hint/phone_number_hint.dart';

class FirstScreenWidget extends StatefulWidget {
  FirstScreenWidget({super.key});

  @override
  State<FirstScreenWidget> createState() => _FirstScreenWidgetState();
}

class _FirstScreenWidgetState extends State<FirstScreenWidget>
    with TickerProviderStateMixin {
  var mobileNumber = "";
  var textController = TextEditingController();
  final _phoneNumberHintPlugin = PhoneNumberHint();
  late Animation<double> logoOpacity;
  late Animation<double> textOpacity;
  late Animation<double> textFieldOpacity;
  late Animation<double> buttonOpacity;
  late Animation<Offset> logoOffset;
  late Animation<Offset> textOffset;
  late Animation<Offset> textFieldOffset;
  late Animation<Offset> buttonOffset;
  late AnimationController logoController;
  late AnimationController textOpacityController;
  late AnimationController textFieldController;
  late AnimationController buttonController;
  late AnimationController logoOffsetController;
  late AnimationController textOffsetController;
  late AnimationController textFieldOffsetController;
  late AnimationController buttonOffsetController;

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getPhoneNumber() async {
    String? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      result = await _phoneNumberHintPlugin.requestHint() ?? '';
      textController.text =
          result.toString().substring(result.toString().length - 10);
      setState(() {
        mobileNumber = textController.text;
      });
    } on PlatformException {
      result = 'Failed to get hint.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var animationDuration = 1000;
    var fadeAnimationDuration = 500;
    var delayStart = 500;
    var delayGap = 100;
    var curve = Curves.elasticOut;
    var opacityCurve = Curves.linear;

    logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: fadeAnimationDuration)
    );
    logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: logoController, curve: opacityCurve));
    logoOffsetController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));
    logoOffset = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: logoOffsetController, curve: curve));

    textOpacityController = AnimationController(
        vsync: this, duration: Duration(milliseconds: fadeAnimationDuration));
    textOpacity =
    Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: textOpacityController, curve: opacityCurve));
    textOffsetController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));
    textOffset = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: textOffsetController, curve: curve));

    textFieldController = AnimationController(
    vsync: this, duration: Duration(milliseconds: fadeAnimationDuration));
    textFieldOpacity =
    Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: textFieldController, curve: opacityCurve));
    textFieldOffsetController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));
    textFieldOffset = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: textFieldOffsetController, curve: curve));

    buttonController = AnimationController(
        vsync: this, duration: Duration(milliseconds: fadeAnimationDuration));
    buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: buttonController, curve: opacityCurve));
    buttonOffsetController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));
    buttonOffset = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: buttonOffsetController, curve: curve));


    Future.delayed(
      Duration(milliseconds: delayStart),
      () => {
      logoController.forward(),
        logoOffsetController.forward()
      },
    );

    Future.delayed(
      Duration(milliseconds: delayStart + (delayGap)),
      () => {
        textOpacityController.forward(),
        textOffsetController.forward()
      },
    );

    Future.delayed(
      Duration(milliseconds: delayStart + (2 * delayGap)),
      () => {
        textFieldController.forward(),
        textFieldOffsetController.forward()
      },
    );
    Future.delayed(
      Duration(milliseconds: delayStart + (3 * delayGap)),
      () => {
        buttonController.forward(),
        buttonOffsetController.forward(),
      },
    );

    Future.delayed(
      Duration(milliseconds: 3000),
      () => {getPhoneNumber()},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
            minHeight: 400,
            maxHeight: double.infinity,
          ),
          color: Colors.white,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SlideTransition(
                        position: logoOffset,
                        child: FadeTransition(
                          opacity: logoOpacity,
                          child: Image.asset(
                            "assets/images/my_bg_image.png",
                            width: (MediaQuery.of(context)
                                    .size
                                    .width
                                    .clamp(0, 600)) *
                                0.5,
                            height: (MediaQuery.of(context)
                                    .size
                                    .width
                                    .clamp(0, 600)) *
                                0.5,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          SlideTransition(
                            position: textOffset,
                            child: FadeTransition(
                              opacity: textOpacity,
                              child: Text(
                                "Welcome to Naariyal Paniwala",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.green.shade700),
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: textOffset,
                            child: FadeTransition(
                              opacity: textOpacity,
                              child: Text(
                                "Har Roz Naariyal Pani Aapke Ghar",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: textFieldOffset,
                            child: FadeTransition(
                              opacity: textFieldOpacity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 24),
                                    height: 50,
                                    child: TextField(
                                      controller: textController,
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
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
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
                                ],
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: buttonOffset,
                            child: FadeTransition(
                              opacity: buttonOpacity,
                              child: Column(
                                children: [
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
                                          Fluttertoast.showToast(
                                              msg: "Invalid number");
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpScreenWidget(
                                                      mobileNumber: mobileNumber,
                                                    )),
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(
                                              Colors.green.shade700),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
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
