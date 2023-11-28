import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_tracker/order_tracker.dart';

import '../../Theme/AppTheme.dart';


class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<TextDto> orderList = [
   TextDto("Your order has been placed", "Tue, 25th Noc '23 - 10:00am"  ),
    TextDto("Seller has processed your order", "Sat, 26th Nov '23 - 08:00pm"),
   // TextDto("Your item has been picked up by courier partner.", "Mon, 27th Nov '23 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '23 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '23 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '23 - 3:58pm"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Track Order'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 3,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: OrderTracker(
              status: Status.shipped,
              activeColor: ColorTheme.bgcolor,
              inActiveColor: Colors.black26,
              orderTitleAndDateList: orderList,
              shippedTitleAndDateList: shippedList,
              outOfDeliveryTitleAndDateList: outOfDeliveryList,
              deliveredTitleAndDateList: deliveredList,
              subDateTextStyle: TextStyle(color: ColorTheme.bgcolor),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width*0.9,
            color: Color(0xFFFFF6EF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(width: 20,),
                      Text('Ali Home' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('63 - R1 Main Blvd, Block R 1 Phase 2 Johar Town, Lahore, Punjab 54000, Pakistan'),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Text("Mobile: "),
                      Text('+923186449413')
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
