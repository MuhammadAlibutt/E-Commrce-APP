import 'package:fahioapp_fyp/Buyer_Side/Auth/login.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../bottamnav_scren.dart';
import '../Add_To_WishList/addtowishlist_provider.dart';
import '../Add_to_Cart/checkout.dart';

class ProductDetailsController extends GetxController {
  bool checkAddToWishList = false;

  void setCheckAddToWishList(bool value) {
    checkAddToWishList = value;
    print('icon: $checkAddToWishList');
    update(); // This will rebuild the widget that uses this controller
  }
}

class ProductDetail extends StatefulWidget {
  final String imegarUrl;
  final String itemName;
  final String itemRating;
  final String itemPrice;
  final String itemDescription;
  final String itemreturn;
  final String storeName;

  const ProductDetail(
      {super.key,
      required this.imegarUrl,
      required this.itemName,
      required this.itemRating,
      required this.itemPrice,
      required this.itemDescription,
        required this.itemreturn,
        required this.storeName
      });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductDetailsController controller =
      Get.find<ProductDetailsController>();
  bool showCompleteText = false;
  bool addToCartStatus = false;
  final addtowishlistobbj = new WishListProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Row(
            children: [
              GetBuilder<ProductDetailsController>(
                builder: (controller) => IconButton(
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      Get.defaultDialog(
                          backgroundColor: ColorTheme.btntxtcolor,
                          title: 'Fashio',
                          middleText: 'Sorry! \n Please Login First',
                          middleTextStyle: TextStyle(fontSize: 18),
                          titleStyle: TextStyle(
                              color: ColorTheme.appLogoText,
                              fontWeight: FontWeight.bold),
                          onConfirm: () {
                            Get.to(()=> LoginPage());
                          },
                          buttonColor: ColorTheme.bgcolor,
                          textConfirm: ('Login'),
                          onCancel: () {});
                    } else {
                      if (controller.checkAddToWishList) {
                        print('moving to wishlist');
                        addtowishlistobbj.delProductFromWishList();
                        Get.snackbar(
                            "Fahio", "Product Remove to your WishList.");
                        controller.setCheckAddToWishList(false);
                      } else {
                        print('moving to wishlist');
                        addtowishlistobbj.addProductToWishList(
                          productImage: widget.imegarUrl,
                          productTitle: widget.itemName,
                          productPrice: widget.itemPrice,
                          productRating: widget.itemRating,
                        );
                        Get.snackbar("Fahio", "Product Add to your WishList.");
                        controller.setCheckAddToWishList(true);
                      }
                    }
                  },
                  icon: controller.checkAddToWishList
                      ? Icon(Icons.favorite, color: ColorTheme.bgcolor)
                      : Icon(Icons.favorite_border, color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: addToCartStatus ? Colors.red : Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          //Product Image View
          SizedBox(
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                widget.imegarUrl,
              ),
            ),
          ),

          // Prodcut small Images View
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imegarUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imegarUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imegarUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imegarUrl,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Product name, Price and Rating
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  widget.itemName.length > 20
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(widget.itemName,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        )
                      : Text(
                          widget.itemName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.itemRating,
                      style: const TextStyle(fontSize: 17)),
                  const SizedBox(
                    width: 2,
                  ),
                  const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 210, 190, 17),
                    size: 15,
                  ),
                  const Spacer(),
                  Text(
                    'PKR ${widget.itemPrice}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Prooduct Descriiptin and other Details
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Details",
                      style: TextStyle(fontSize: 20, color: Colors.black , fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                      showCompleteText
                      ?widget.itemDescription
                      : widget.itemDescription
                          ,style: TextStyle(fontSize: 18 , color: Colors.grey[700])
                  ),
                ),
                TextButton(
                    onPressed: () {
                      print('item description: ${widget.itemDescription}');
                      setState(() {
                        showCompleteText = !showCompleteText;
                      });
                    },
                    child:
                        Text(showCompleteText ? "show less" : "show more")),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                 Padding(
                  padding: EdgeInsets.only(top: 10, left: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Store: ${widget.storeName.toString()}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Delivery and Returns",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                 Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                      alignment: Alignment.center,
                      child:
                          Text(widget.itemreturn)),
                )
              ],
            ),
          ),

          // Add To Cart bottom naviigation bar
          Expanded(

            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, bottom: 8, right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.storefront,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 8, right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.yellow[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            size: 25,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Buy Now  ",
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.orange[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 25,
                          ),
                          TextButton(
                            onPressed: () {
                             Get.to(CheckOutScreen(
                               productImage: widget.imegarUrl,
                               price: widget.itemPrice,
                               rating: widget.itemRating,
                               title: widget.itemName,
                               storeName: widget.storeName,
                             ));
                            },
                            child: Text(
                              "Add to Cart  ",
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

