import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String userID, File file, String imgID) async {
    Reference ref = _storage.ref().child(userID).child(imgID);
    Uint8List? data = await testCompressFile(file);

    UploadTask uploadTask = ref.putData(data!);

    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadPostToStorage(
      String userID, File file, String imgID) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      Reference rootReference = storage.ref();

      // Create a folder named 'posts'
      Reference postsFolderReference = rootReference.child(userID);

      // Create a folder named after the user's ID
      Reference userFolderReference =
      postsFolderReference.child(FirebaseAuth.instance.currentUser!.uid);

      // Create an image file named after the post ID within the user's folder
      Reference ref = userFolderReference.child(imgID);

      Uint8List? data = await testCompressFile(file);

      UploadTask uploadTask = ref.putData(data!);

      TaskSnapshot snap = await uploadTask;
      String downloadURL = await snap.ref.getDownloadURL();
      return downloadURL;
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      return '';
    }
  }
}

Future<Uint8List?> testCompressFile(File file) async {
  try {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 0,
    );
    return result;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
