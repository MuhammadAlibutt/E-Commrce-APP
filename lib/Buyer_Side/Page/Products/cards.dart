import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Page/Products/FetchProductFromFirebaseWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Category/Boy_category_screens/boy_category.dart';
import '../Category/girl_category_screens/girlcategory.dart';
import '../Category/man_category_screens/MenCatgory.dart';
import '../Category/woman_category_screens/Womencategory.dart';
import '../suggest_outfit/Suggest_outfit.dart';
import 'Prooduct_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final List<String> _imageSlider = [
    "assets/images/fashio2.jpg",
    "assets/images/fashio2.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),

            //discover text
            const Text(
              "Discover",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),

            //to show icon and category
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //suggest m outfit
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.width*0.24,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/suggst.png' ,),
                                fit: BoxFit.fitWidth
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Get.to(OutfitGeneration());
                        },
                        child:  Text('Suggest me OutFit'),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.0001,),

                  //men
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/man.png' ,),
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                         Get.to(()=> ManCollection());
                        },
                        child:  Text('Men'),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),

                  //woman
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/woman.png' ,),
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Get.to(()=> WomenCollection());
                        },
                        child:  Text('Women'),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),

                  //boys
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/boy.png' ,),
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Get.to(()=> BoyCategory());
                        },
                        child:  Text('Boy'),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),

                  //girl
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/girl.png' ,),
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                      ),

                     
                      TextButton(
                        onPressed: (){
                          Get.to(()=> GirlCollection());
                        },
                        child:  Text('Girl'),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // to show slider
            CarouselSlider(
              items: _imageSlider
                  .map((String imagepath) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Image.asset(
                          imagepath,
                          fit: BoxFit.fill,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                enableInfiniteScroll: true,
                autoPlay: true,
                height: 150,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // to show products
            ProductListView(),
          ],
        ),
      ),
    );
  }
}

class ProductListView extends StatefulWidget {
  ProductListView({super.key});
  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<dynamic> sortedApiProductList = [];
  bool addToWishList = true;
  bool filledIcon = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Trending Products",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: AllProducts()
        )
      ],
    );
  }
}
