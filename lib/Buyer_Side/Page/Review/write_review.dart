

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Page/Review/toreview.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../Theme/AppTheme.dart';

class WriteReview extends StatefulWidget {
  final String imegarUrl;
  final String itemName;
  final String storeName;

  WriteReview(
      {super.key,
      required this.imegarUrl,
      required this.itemName,
      required this.storeName});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final _feedback = TextEditingController();
  final _riderfeedback = TextEditingController();
  double productRating = 2.0;
  double riderRating = 2.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Review'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(ToReview());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              color: Colors.grey[400],
              child: Text(
                'Product Quality',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 20,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.network(widget.imegarUrl),
                    ),
                  ),
                  Positioned(
                    left: 170,
                    top: 40,
                    child: Text(
                      widget.itemName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Positioned(
                    left: 170,
                    top: 80,
                    child: Text(
                      widget.storeName,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 50,
              color: Colors.grey[200],
            ),

            //product rating
            RatingBar.builder(
              initialRating: 2,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  productRating = rating;
                });
                print(productRating);
              },
            ),
            Divider(
              thickness: 1,
              height: 50,
              color: Colors.grey[400],
            ),
            TextFormField(
              controller: _feedback,
              decoration: InputDecoration(
                label: Text('Enter your FeedBack'),
                prefixIcon: Icon(Icons.message , color: ColorTheme.bgcolor,),
                //fillColor: _emailController.text.isEmpty ? Colors.red : Colors.white,
                //errorText:  _emailController.text.isEmpty ? "Please Fill The Field" : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              //validator: validateEmail,
            ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.03,
           ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              color: Colors.grey[300],
              child: Text(
                'Rider Review',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //rider ratting
            RatingBar.builder(
              initialRating: 2,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  riderRating = rating;
                });
                print(rating);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.04,
            ),
            TextFormField(
              controller: _riderfeedback,
              decoration: InputDecoration(
                label: Text('Enter your FeedBack'),
                prefixIcon: Icon(Icons.message , color: ColorTheme.bgcolor,),
                //fillColor: _emailController.text.isEmpty ? Colors.red : Colors.white,
                //errorText:  _emailController.text.isEmpty ? "Please Fill The Field" : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              //validator: validateEmail,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.07,
              width: MediaQuery.of(context).size.width*0.7,
              child: ElevatedButton(
                  onPressed: () async{
                    FirebaseFirestore.instance.collection('Reivew').doc(widget.storeName).set({
                      'product_img' : widget.imegarUrl,
                      'product_name': widget.itemName,
                      'product_review': _feedback.text,
                      'product_rating': productRating,
                      'rider_review': _riderfeedback.text,
                      'rider_rating' : riderRating
                    }).then((value) {
                      Get.to(()=> BottomNavBar(currentIndex: 0,));
                      Get.snackbar("fashio", 'Thank for FeedBack');
                    });
                    deleteProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.bgcolor,
                    foregroundColor: ColorTheme.btntxtcolor
                  ),
                  child: Text("Submit your review" ,style: TextStyle(fontSize: 15),)
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> deleteProduct() async {
    CollectionReference toReviewCollection = FirebaseFirestore.instance.collection('ToReview');

    // Query for documents that contain the product with the specified ID
    QuerySnapshot querySnapshot = await toReviewCollection.where('product.product', isEqualTo: widget.itemName).get();
    print('product : ${querySnapshot.toString()}');
    // Iterate through the result documents and delete the product from each
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      String docId = documentSnapshot.id;

      // Get the product list
      List<dynamic> productList = documentSnapshot['productt'];

      // Remove the product with the specified ID
      productList.removeWhere((product) => product['product'] == widget.itemName);

      // Update the document with the modified product list
      await toReviewCollection.doc(docId).update({'product': productList});
    }
  }
}
