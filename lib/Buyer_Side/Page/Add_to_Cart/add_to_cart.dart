import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Theme/AppTheme.dart';
import 'checkout_information.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  Map<String, dynamic>? data = {};
  int docLenght = 0;
  List<Map<String, String>> productsData = [];
  int totalAmount = 0;
  String imgUrlPassing ='';
  final GetStorage _getStorage = GetStorage();
  //bool checkwishlisticon = false;

  // cart data from firebase
  Future<void> CartProducts() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user')
          .get();
      docLenght = querySnapshot.docs.length;
      print('length $docLenght');
      print('user id : ${FirebaseAuth.instance.currentUser!.uid}');
      productsData.clear();
      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          data = doc.data() as Map<String, dynamic>?;
          print('data $data');
          print('data ${data?.length}');
          if (data != null) {
            final String url = data?['product_image'];
            final String product = data?['product_title'];
            final String rating = data?['product_rating'];
            final String price = data?['product_price'];
            final String size = data?['product_size'];
            final int quantity = data?['product_quantity'];
            final String storeName = data?['Store_Name'];
            productsData.add({
              'product': product.toString(),
              'imageUrl': url.toString(),
              'rating': rating.toString(),
              'price': price.toString(),
              'size': size.toString(),
              'quantity': quantity.toString(),
              'storeName' : storeName.toString(),
            });
            print('$productsData');
          }
        }
      } else {
        Center(
          child: Text(
            'No Producted Added to Cart yet',
            style: TextStyle(fontSize: 18),
          ),
        );
      }
    } catch (e) {
      print('Error while removing from Wishlist: $e');
    }
  }

  Future<dynamic> delProductFromWishList(String productTitle) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('user')
          .where('product_title', isEqualTo: productTitle)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('Cart')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('user')
              .doc(doc.id)
              .delete();
        }
        return true;
        print('Products removed from Wishlist');
      } else {
        print('Products not found in Wishlist');
        return false;
      }
    } catch (e) {
      print('error while removing from Wishlist $e');
      return false;
    }
  }

  //total price
  int totalPrice() {
    int totalAmount;
    int total = 0;
    for (int i = 0; i < productsData.length; i++) {
      String? priceString = productsData[i]['price'];
      int productPrice = int.tryParse(priceString!) ?? 0;
      total += productPrice;
      print('total: $total');
    }
    return totalAmount = total;
  }

  Future<void> fetchData() async {
    await CartProducts();
    setState(() {
      // Trigger a rebuild of the UI
      totalAmount = totalPrice();
      docLenght = productsData.length;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {
      // Trigger a rebuild of the UI
      totalAmount = totalPrice();
      docLenght = productsData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Item"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [


          //Product details
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: CartProducts(),
              builder: (context, snapShots) {
                if (snapShots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorTheme.bgcolor,
                    ),
                  );
                } else if (snapShots.hasError) {
                  return Text("Some Error Please try again");
                } else
                  //if(snapShots.hasData )
                  {
                  return ListView.builder(
                      itemCount: productsData.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.24,
                              width: MediaQuery.of(context).size.width * 0.84,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: BoxShadow
                              ),
                              child: Stack(
                                children: [
                                  //image
                                  Positioned(
                                    left: 15,
                                    top: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () async {},
                                        child: Image.network(
                                          productsData[index]['imageUrl']!,
                                          fit: BoxFit.fill,
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                          width: MediaQuery.of(context).size.width *
                                              0.27,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // delete button
                                  Positioned(
                                      top: 20,
                                      left: 280,
                                      child: SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width * 0.4,
                                        child: IconButton(
                                          onPressed: () async {
                                            bool success =
                                            await delProductFromWishList(
                                                productsData[index]
                                                ['product']!);
                                            if (success) {
                                              setState(() {
                                                productsData.removeAt(index);
                                                totalAmount = totalPrice();
                                                docLenght = productsData.length;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),
                                  //title
                                  Positioned(
                                      top: 30,
                                      left: 155,
                                      child: SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          productsData[index]['product']!,
                                          style: TextStyle(fontSize: 20),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),

                                  //store name
                                  Positioned(
                                      top: 65,
                                      left: 155,
                                      child: SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          productsData[index]['storeName']!,
                                          style: TextStyle(fontSize: 13),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),

                                  //Size
                                  Positioned(
                                    top: 85,
                                    left: 155,
                                    child: Text(
                                      "Size:${productsData[index]['size']}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),

                                  //price
                                  Positioned(
                                    bottom: 45,
                                    left: 155,
                                    child: Text(
                                      "PKR ${productsData[index]['price']!}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  //rating
                                  Positioned(
                                    bottom: 50,
                                    right: 35,
                                    child: Text(
                                      productsData[index]['rating']!,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),

                                  //icon
                                  Positioned(
                                      bottom: 49,
                                      right: 10,
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      )),
                                ],
                              ),
                            ));
                      });
                }
                // else{
                //
                //   return Center(
                //     child: Text("Cart is Empty" , style: TextStyle(fontSize: 20 ,color: ColorTheme.bgcolor),),
                //   );
                // }
              },
            ),
          ),


          // total price and quantity
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Total Item:${productsData.length}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  "Total:${totalPrice()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),


          //check out button
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {
                if(productsData.isEmpty)
                  {
                    Get.snackbar("fashio", 'Please add products to Cart');

                  }
                else
                  {
                    _getStorage.write('total', totalPrice());
                  _getStorage.write('productDetails', productsData);
                  Get.to(CheckOutInformation(
                    productData: productsData,
                    totalAmount: totalPrice(),
                  ));
                  }

              },
              child: Text(
                "CheckOut",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.bgcolor,
                  foregroundColor: ColorTheme.btntxtcolor),
            ),
          )
        ],
      ),
    );
  }
}
