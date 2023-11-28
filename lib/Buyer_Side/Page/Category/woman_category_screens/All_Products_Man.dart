import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Products/Prooduct_detail.dart';


class AllWomenProducts extends StatefulWidget {
  const AllWomenProducts({super.key});

  @override
  State<AllWomenProducts> createState() => _AllWomenProductsState();
}

class _AllWomenProductsState extends State<AllWomenProducts> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('AllAddProduct').where('Cateory' , isEqualTo: 'Women').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No Products found'),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              mainAxisExtent: 300),
          itemCount:snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            // data.sort(
            //         (a, b) => b['rating']['rate'].compareTo(a['rating']['rate']));
            return Card(
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () async {
                          final imageUrl =
                          data['Product_Image'];
                          final itemName =
                          data['Item_Name'];
                          Get.to(
                            ProductDetail(
                              imegarUrl: imageUrl,
                              itemName: itemName,
                              itemRating: data['Item_Quantity']
                                  .toString(),
                              itemPrice: data['Item_Price']
                                  .toString(),
                              itemDescription: data['Item_Detail'],
                              itemreturn: data['Item_Delivery'],
                              storeName: data['Store_Name'],
                            ),
                          );
                        },
                        child: Image.network(
                          data['Product_Image'],
                          fit: BoxFit.fill,
                          height:MediaQuery.of(context).size.height*0.15,
                          width: MediaQuery.of(context).size.width*0.27,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 55,
                    left: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(data['Item_Name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 10,
                    child: Text(
                        'PKR ${data['Item_Price'].toString()}'),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 5,
                    child: Row(
                      children: [
                        Text('5'),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 10,
                    child: Text(
                        'Store: ${data['Store_Name'].toString()}'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
