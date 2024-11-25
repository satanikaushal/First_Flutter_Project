import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  ImagePicker _imagePicker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.grey,
              margin: EdgeInsets.all(15),
              child: Center(
                child: file == null
                    ? Text("Choose an Image")
                    : Image.file(
                  File(file!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: Text("Choose Image"))
          ],
        ),
      ),
    );
  }

  Future _pickImage() async {
    final photo = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (photo != null) {
        file = photo;
      }
    });
  }
}
