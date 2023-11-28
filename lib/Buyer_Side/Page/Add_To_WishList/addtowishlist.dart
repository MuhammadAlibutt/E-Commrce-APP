

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/AppTheme.dart';
import '../../bottamnav_scren.dart';
import 'addtowishlist_provider.dart';



class AddToWishList extends StatefulWidget {
  const AddToWishList({super.key});

  @override
  State<AddToWishList> createState() => _AddToWishListState();
}
class _AddToWishListState extends State<AddToWishList> {
   Map<String, dynamic>? data = {};
   int docLenght = 0;
  List<Map<String, String>> productsData = [];
  bool checkwishlisticon = false;
   final addtowishlistobbj = new WishListProvider();
  //fetching data from databbase
  Future<void> seeProductFromWishList() async {
    try {
     final QuerySnapshot querySnapshot = await FirebaseFirestore
         .instance
         .collection('WishList')
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .collection('products')
         .get();
     docLenght = querySnapshot.docs.length;
     print('length $docLenght');
     print ('user id : ${FirebaseAuth.instance.currentUser!.uid}');
     productsData.clear();
      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
           data = doc.data() as Map<String,
              dynamic>?;
           print('data $data');
           print('data ${data?.length}');
           if (data != null) {
            final String url = data?['product_image']  ;
            final String product = data?['product_title'] ;
            final String rating = data?['product_rating'] ;
            final String price = data?['product_price'] ;
            productsData.add({
              'product': product.toString(),
              'imageUrl': url.toString(),
              'rating': rating.toString(),
              'price': price.toString(),
            });
            print('$productsData');
          }
        }
      }else {
          print('Data is null');
        }
    } catch (e) {
      print('Error while removing from Wishlist: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 1,
            height: 30,
            color: Colors.grey,
          ),
          Expanded(
            child: FutureBuilder(
              future: seeProductFromWishList(),
              builder: (context , snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorTheme.bgcolor,
                    ),
                  );
                     // Show a loading indicator
                }else if (snapshot.hasError) {
                  return  const Center(
                     child: Text("Some Error Plase Try Again")
                  );
                } else
                  {
                    return  GridView.builder(
                            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                mainAxisExtent: 270
                            ),
                            itemCount: productsData.length,
                            itemBuilder: (context , index ){
                              return Card(
                                child:Stack(
                                  children: [
                                    Positioned(
                                      right: 1,
                                        child:
                                    IconButton(
                                      onPressed: (){
                                        addtowishlistobbj.delProductFromWishList();
                                        setState(() {
                                          checkwishlisticon = !checkwishlisticon;
                                        });
                                      },
                                      icon: checkwishlisticon
                                      ?Icon(Icons.favorite_border_outlined, color: ColorTheme.bgcolor,)
                                      :Icon(Icons.favorite, color: ColorTheme.bgcolor,
                                      )
                                    )
                                    ),
                                    //image
                                    Positioned(
                                      left : 15,
                                        top: 20,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: GestureDetector(
                                            onTap: () async {

                                            },
                                            child: Image.network(
                                              productsData[index]['imageUrl']!,
                                              fit: BoxFit.fill,
                                              height:MediaQuery.of(context).size.height*0.15,
                                              width: MediaQuery.of(context).size.width*0.27,
                                            ),
                                          ),
                                        ),
                                    ),
                                    //title
                                    Positioned(
                                      top: 200,
                                        left: 4,
                                        child: SizedBox(
                                         width: MediaQuery.of(context).size.width*0.4,
                                         child: Text(productsData[index]['product']! ,
                                         maxLines: 3,
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                        )
                                    ),
                                   //price
                                   Positioned(
                                    bottom: 20,
                                       left: 4,
                                       child:
                                           Text("\$${productsData[index]['price']!}"),
                                   ),
                                    //rating
                                    Positioned(
                                      bottom: 20,
                                      right: 30,
                                      child:
                                        Text(productsData[index]['rating']!),
                                        ),
                                    //icon
                                    Positioned(
                                      bottom: 19,
                                        right: 5,
                                        child:
                                        Icon(Icons.star , color: Colors.yellow,)
                                    ),
                                  ],
                                ),
                              );
                    }
                    );
                  }
              },
            )
          )
        ],
      ),
    );
  }
}
