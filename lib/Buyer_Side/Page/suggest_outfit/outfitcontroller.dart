import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Page/suggest_outfit/storage_mthod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'global.dart';
import 'outfit_model.dart';

class Outfit {
  Future<void> uploadOutfit({
    String? rating,
    required dynamic image,
    required List<String> filter,
  }) async {
    try {
      String userId = firebaseAuth.currentUser!.uid;
      var outfitId = const Uuid().v4();
      //upload image to storage
      String photoUrl =
      await StorageMethod().uploadPostToStorage('outfits', image, outfitId);
      OutfitModel postModel = OutfitModel(
        userId: userId,
        image: photoUrl,
        rating: rating,
        filter: filter,
        outfitId: outfitId,
      );
      await FirebaseFirestore.instance.collection('outfits').doc(outfitId).set(
        postModel.toJson(),
      );
      Get.snackbar('Success', 'Oufit uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }
}
