import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Page/Review/write_review.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ToReview extends StatefulWidget {
  const ToReview({super.key});

  @override
  State<ToReview> createState() => _ToReviewState();
}

class _ToReviewState extends State<ToReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Review"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 3,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ToReview').
       snapshots(),
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
              child: Text('No Products found.'),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                mainAxisExtent: 200),
            itemCount:snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

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
                            data['product'][0]['imageUrl'];
                            final itemName =
                            data['product'][0]['product'];
                            final store =
                            data['product'][0]['storeName'];
                            Get.to(
                              WriteReview(
                                imegarUrl: imageUrl,
                                itemName: itemName,
                                storeName: store,
                              ),
                            );
                          },
                          child: Image.network(
                            data['product'][0]['imageUrl'],
                            fit: BoxFit.fill,
                            height:MediaQuery.of(context).size.height*0.15,
                            width: MediaQuery.of(context).size.width*0.27,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                     top: 30,
                      left: 200,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                            data['product'][0]['product'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 200,
                      child: Text(
                          'PKR ${data['product'][0]['price'].toString()}'
                      ),
                    ),
                    Positioned(
                      top: 150,
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
                      top: 100,
                      left: 200,
                      child: Text(
                          'Store: ${data['product'][0]['storeName'].toString()}'
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      )
    );
  }
}
