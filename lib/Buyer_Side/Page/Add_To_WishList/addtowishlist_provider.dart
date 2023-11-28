import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class WishListProvider with ChangeNotifier {


  String? productid;
   GetStorage _getStorage = GetStorage();
  Future<void> addProductToWishList({
    String? productImage,
    String? productTitle,
    String? productRating,
    String? productPrice,
  }) async {
    try {
       productid =  FirebaseFirestore.instance
          .collection('WishList')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('products')
          .doc().id;
       _getStorage.write('wishListProductId', productid);
      print('productid: $productid');
      await FirebaseFirestore.instance
          .collection('WishList')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('products')
          .doc(productid)
          .set({
        "product_image": productImage,
        "product_title": productTitle,
        "product_rating": productRating,
        "product_price": productPrice,
      });
    } catch (e) {
      print('failed: $e');
    }
  }


  Future<dynamic> delProductFromWishList()
  async {
    try
    {
      print('productid: $productid');
    String  wishListproductid = _getStorage.read('wishListProductId');
    print('wishList: $wishListproductid');
      await FirebaseFirestore
          .instance
          .collection('WishList')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('products')
          .doc(wishListproductid)
          .delete();
      print ('removed from Wishlist');
    }
    catch(e){
      print ('error while removing from Wishlist $e');
    }
  }
}

//HvMYZIG0NLVWiiKgC1AX