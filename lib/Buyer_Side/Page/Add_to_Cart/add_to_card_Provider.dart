import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AddToCartProvider {
  String? productid;
  GetStorage _getStorage = GetStorage();

  Future<void> addProductToCart({
    String? productImage,
    String? productTitle,
    String? productRating,
    String? productPrice,
    int? productquantity,
    String? productsize,
    String? storeName,
  }) async {
    try {
      productid = FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user')
          .doc()
          .id;
      _getStorage.write('cartProductId', productid);
      print('productid: $productid');
      await FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user')
          .doc()
          .set({
        "product_image": productImage,
        "product_title": productTitle,
        "product_rating": productRating,
        "product_price": productPrice,
        "product_quantity": productquantity,
        "product_size": productsize,
        "Store_Name": storeName,
      });
    } catch (e) {
      print('failed: $e');
    }
  }

// product user details
  Future<void> userShippingDetails({
    String? userEmail,
    String? userName,
    String? userAddress,
    String? userCity,
    String? cityPostCode,
    String? promoCode,
    int? total,
    String? payment,
    List<Map<String, dynamic>>? productDetails,
  }) async {
    try {
      // Iterate through the productDetails to group products by store name
      Map<String, List<Map<String, dynamic>>> groupedProducts = {};

      if (productDetails != null) {
        for (var product in productDetails) {
          String storeName = product[
              'storeName']; // Adjust the key based on your actual structure
          if (!groupedProducts.containsKey(storeName)) {
            groupedProducts[storeName] = [];
          }
          groupedProducts[storeName]!.add(product);
        }
      }

      // Save shipping details for each store
      for (var storeName in groupedProducts.keys) {
        await FirebaseFirestore.instance
            .collection('Shipping_Details')
            .doc(storeName)
            .set({
          "User_Email": userEmail,
          "User_Name": userName,
          "User_Address": userAddress,
          "City": userCity,
          "City_Code": cityPostCode,
          "Promo_Code": promoCode,
          "Shop_Name": storeName,
          "Products_Details": groupedProducts[storeName],
          "Total_Price": total,
          'payment_Method' : payment
        });
      }
    } catch (e) {
      print('Failed: $e');
    }
  }

  Future<void> delProductFromCart() async {
    try {
      CollectionReference cartCollection = FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user');
      QuerySnapshot querySnapshot = await cartCollection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }

      print('All documents removed from Cart');
    } catch (e) {
      print('Error while removing documents from Cart: $e');
    }
  }



  Future<void> addProductToReview({
    List<Map<String, dynamic>>? dataList,
    // String? productTitle,
    // String? productRating,
    // String? productPrice,
    // int? productquantity,
    // String? productsize,
    // String? storeName,
  }) async {
    try {
      productid = FirebaseFirestore.instance
          .collection('Review')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user')
          .doc()
          .id;
      _getStorage.write('cartProductId', productid);
      print('productid: $productid');
      await FirebaseFirestore.instance
          .collection('ToReview')
          .doc()
          .set({
        "product": dataList,
        // "product_title": productTitle,
        // "product_rating": productRating,
        // "product_price": productPrice,
        // "product_quantity": productquantity,
        // "product_size": productsize,
        // "Store_Name": storeName,
      });
    } catch (e) {
      print('failed: $e');
    }
  }
}
