import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'image_selector.dart';


Future<File?> selectImage() async {
  try {
    File? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      return im;
    } else {
      return null; // Return null when no image is selected.
    }
  } catch (e) {
    Get.snackbar('Failed', e.toString());
    return null; // Return null on failure as well.
  }
}
Future<File?> captureImage() async {
  try {
    File? im = await pickImage(ImageSource.camera);
    if (im != null) {
      return im;
    } else {
      return null; // Return null when no image is selected.
    }
  } catch (e) {
    Get.snackbar('Failed', e.toString());
    return null; // Return null on failure as well.
  }
}
