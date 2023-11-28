import 'package:fahioapp_fyp/Buyer_Side/Page/Tracking/track_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Page/Cards/Card_Screen.dart';
import '../Page/Review/toreview.dart';
import '../bottamnav_scren.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool buttonSelected = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          //first container
          Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "My order",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.payment,
                          size: 30,
                        ),
                        TextButton(onPressed: () {
                          Get.to(()=>CardScreen());
                        }, child: Text("To Pay"))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 30,
                        ),
                        TextButton(onPressed: () {}, child: Text("To Ship"))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.local_shipping_rounded,
                          size: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(TrackOrder());
                            },
                            child: Text("To Recive"))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.reviews_outlined,
                          size: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(ToReview());
                            },
                            child: Text("To Reviw "))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          //second container
          Container(
            alignment: Alignment.topLeft,
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "Payments & Discounts",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image(image: AssetImage('assets/images/pay.png')),
                        TextButton(onPressed: () {}, child: Text("Cards"))
                      ],
                    ),
                    Column(
                      children: [
                        Image(image: AssetImage('assets/images/voucher.png')),
                        TextButton(onPressed: () {}, child: Text("Voucher "))
                      ],
                    ),
                    Column(
                      children: [
                        Image(image: AssetImage('assets/images/promo.png')),
                        TextButton(onPressed: () {}, child: Text("Promo Code "))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          //Tab bar
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.48,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text("My Return"),
                      ),
                      Tab(
                        child: Text('My Cancelation'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      // my return Container
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text("Order No.1234567"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text("Request on:03 Nov 2023"),
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/boy_collection/boy_jacket1.jpeg'),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Boys Jacket",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "Size: S",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "PKR 1,200",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      // my cancelation container
                      Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: MediaQuery.of(context).size.height * 0.48,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text("Order No.1234567"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text("Request on:03 Nov 2023"),
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/boy_collection/boyshirt2.jpg'),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Boys Jacket",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "Size: S",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "PKR 1,200",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      //
                    ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
