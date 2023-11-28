import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottamnav_scren.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Notification').snapshots(),
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
              child: Text('No Notification Yet'),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
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
                            // Get.to(YourScreen());
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
                      top: 35,
                      left: 150,
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
                      top: 70,
                      left: 150,
                      child: Text(
                          'PKR ${data['Item_Price'].toString()}'),
                    ),
                    Positioned(
                      bottom: 50,
                      left:3,
                      child: Text('Your order is on it way! Thank for Shoping From Fahsio!',
                      style: TextStyle(color: ColorTheme.bgcolor),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 150,
                      child: Text(
                          'Store: ${data['Store_Name'].toString()}'),
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
