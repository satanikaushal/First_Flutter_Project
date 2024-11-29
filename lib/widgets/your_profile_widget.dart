import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class YourProfileWidget extends StatefulWidget {
  const YourProfileWidget({super.key});

  @override
  State<YourProfileWidget> createState() => _YourProfileWidgetState();
}

class _YourProfileWidgetState extends State<YourProfileWidget> {
  XFile? file;
  ImagePicker imagePicker = ImagePicker();

  var inputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightGreen.shade800, width: 2),
        borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightGreen.shade800, width: 2),
        borderRadius: BorderRadius.circular(10)),
    contentPadding: EdgeInsets.symmetric(horizontal: 15),
    hintStyle: GoogleFonts.poppins(
      color: Colors.grey.shade500,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    counterText: "",
    hintFadeDuration: Duration(milliseconds: 300),
  );

  @override
  Widget build(BuildContext context) {
    Widget bottomSheet = Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width, maxHeight: 290),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 5.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.lightGreen.shade800,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Select Camera or Gallery",
                style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 47,
            child: FilledButton(
              onPressed: () async {
                final tempFile =
                    await imagePicker.pickImage(source: ImageSource.camera);
                if (tempFile != null) {
                  setState(() {
                    file = tempFile;
                  });
                }
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.lightGreen.shade100),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: Text(
                "Camera",
                style: GoogleFonts.poppins(
                    color: Colors.lightGreen.shade800,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 47,
            child: FilledButton(
              onPressed: () async {
                final tempFile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (tempFile != null) {
                  setState(() {
                    file = tempFile;
                  });
                }
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.lightGreen.shade800),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: Text(
                "Gallery",
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Your Profile",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                color: Colors.lightGreen.shade800,
                fontSize: 19)),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.lightGreen.shade800,
            )),
        centerTitle: true,
        elevation: 1,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.shade100,
      ),
      bottomNavigationBar: Container(
        height: 87,
        padding: EdgeInsets.only(top: 14, bottom: 24, left: 24, right: 24),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 0)
        ]),
        child: FilledButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Colors.lightGreen.shade800),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: Text(
            "Save",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Row(),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return bottomSheet;
                        },
                        backgroundColor: Colors.transparent
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade800,
                    radius: 50,
                    child: file != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Image.file(File(file!.path),
                                height: 100, width: 100, fit: BoxFit.cover))
                        : Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Profile Photo",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // first name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "First Name",
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        cursorOpacityAnimates: true,
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter First Name"),
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        maxLength: 50,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              return TextEditingValue(
                                  text: newValue.text.replaceAll("  ", " "));
                            },
                          )
                        ],
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      // last name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Last Name",
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration.copyWith(
                          hintText: "Enter Last Name",
                        ),
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        maxLength: 50,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              return TextEditingValue(
                                  text: newValue.text.replaceAll("  ", " "));
                            },
                          )
                        ],
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      // mobile number
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Number *",
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration.copyWith(
                          hintText: "Mobile Number",
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "+91",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Container(
                                width: 1, // Thickness of the line
                                height: 15, // Height of the line
                                color: Colors.black, // Color of the line
                              ),
                              SizedBox(
                                width: 13,
                              )
                            ],
                          ),
                          // prefixIconConstraints: BoxConstraints(minWidth: 70),
                        ),
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      // email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        decoration: inputDecoration.copyWith(
                          hintText: "Enter Email",
                        ),
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        maxLength: 50,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              return TextEditingValue(
                                  text: newValue.text.replaceAll(" ", ""));
                            },
                          )
                        ],
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                      ),

                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
