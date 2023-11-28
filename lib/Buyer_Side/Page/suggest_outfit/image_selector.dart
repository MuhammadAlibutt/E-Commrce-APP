import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? xFile = await imagePicker.pickImage(source: source);

  if (xFile != null) {
    // Convert XFile to File
    File file = File(xFile.path);
    return file;
  } else {
    print("No image selected");
    return null;
  }
}