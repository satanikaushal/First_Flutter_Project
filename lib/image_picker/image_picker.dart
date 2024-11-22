import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  final ImagePicker imagePicker = ImagePicker();
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
                child: file == null ? Text("Choose an Image") : Image.file(
                  File(file!.path)
                ),
              ),
            ),
            ElevatedButton(onPressed: () async {

            }, child: Text("Choose Image")
            )
          ],
        ),
      ),
    );
  }
}
