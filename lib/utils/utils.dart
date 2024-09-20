import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker= ImagePicker();

  XFile? ffile = await imagePicker.pickImage(source: source);

  if (ffile != null) {
    return await ffile.readAsBytes();
  }
  print("no image selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
    ),
  ));
}
