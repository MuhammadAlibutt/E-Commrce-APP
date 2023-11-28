import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Theme/AppTheme.dart';
import '../Payment/confirming_order.dart';
import 'add_to_card_Provider.dart';
import 'checkout_information.dart';

class CheckOutInformationShipping extends StatefulWidget {
  // final String? usermail;
  // final String? userName;
  // final String? userLastName;
  // final String? userAddress;
  // final String? userCity;
  // final String? cityPostCode;
  // final String? promoCode;
  // final List<Map<String, String>>? productData;
  // final int? totalPrice;

  CheckOutInformationShipping(
      {super.key,
      //  this.usermail,
      //  this.userName,
      //  this.userLastName,
      //  this.userAddress,
      //  this.userCity,
      //  this.cityPostCode,
      //  this.promoCode,
      // this.productData,
      //   this.totalPrice,
      });

  @override
  State<CheckOutInformationShipping> createState() =>
      _CheckOutInformationShippingState();
}

class _CheckOutInformationShippingState
    extends State<CheckOutInformationShipping> {
  AddToCartProvider obj = new AddToCartProvider();
  String? userEmail;
  String? address;
  int subTotal = 0;
  final GetStorage _getStorage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    print('email: $userEmail');
    print('address: $address');
    print('address: $subTotal');
  }
  void _loadData(){
    userEmail  = _getStorage.read('email') ?? '';
    address = _getStorage.read('address') ?? '';
    subTotal = _getStorage.read('total');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("checkout"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(CheckOutInformation(
              // productData: widget.productData,
              // totalAmount: widget.totalPrice,
            ));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 8,
            height: 20,
            color: Colors.grey[200],
          ),
          //contact Info
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Contact Infomation",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      Get.to(CheckOutInformation(
                        // productData: widget.productData,
                        // totalAmount: widget.totalPrice,
                      ));
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                        color: ColorTheme.bgcolor,
                      ),
                    )),
              ),
            ],
          ),

          //conact txtt field
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.073,
              width: MediaQuery.of(context).size.width*0.9,
              child: InputDecorator(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,color: ColorTheme.bgcolor),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                child: Text(userEmail ?? ''
                    //widget.usermail.toString()
                ),
              ),
            )
          ),

          //shipping address field
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.073,
              width: MediaQuery.of(context).size.width*0.9,
              child: InputDecorator(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on,color: ColorTheme.bgcolor),
                    labelText: "Ship To",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                child: Text(
                    address ?? ''
                    //'${widget.userAddress.toString() + widget.userCity.toString()}'
                ),
              ),
            )
          ),

          Divider(
            thickness: 8,
            height: 20,
            color: Colors.grey[200],
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Shipping Charges",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),

          //sub total
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sub total",
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PKR $subTotal",
                  //"PKR ${widget.totalPrice}",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ],
          ),

          //shipping charges
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Shipping Charge",
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PKR 300",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ],
          ),

          Divider(
            thickness: 1,
            height: 10,
            color: Colors.black,
          ),

          //total
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Total",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( 'PKR ${subTotal + 300}',
                 // "PKR ${widget.totalPrice! + 300}",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    // obj.userShippingDetails(
                    //   userEmail: widget.usermail,
                    //   userName: widget.userName! + widget.userLastName!,
                    //   userAddress: widget.userAddress,
                    //   userCity: widget.userCity,
                    //   cityPostCode: widget.cityPostCode ?? '',
                    //   promoCode: widget.promoCode?? '',
                    //   productDetails: widget.productData,
                    // );
                    _getStorage.write('totalAmount', subTotal + 300);
                    Get.to(CorfirmingOrder(
                      // usermail:  widget.usermail,
                      // userName: widget.userName,
                      // userAddress:  widget.userAddress,
                      // userCity:widget.userCity,
                      // cityPostCode: widget.cityPostCode ?? '',
                      // promoCode: widget.promoCode?? '',
                      // productData: widget.productData,
                      // totalPrice: widget.totalPrice,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.bgcolor,
                    foregroundColor: ColorTheme.btntxtcolor,
                  ),
                  child: const Text("Continue Payment"),
                )),
          ),
        ],
      ),
    );
  }
}
