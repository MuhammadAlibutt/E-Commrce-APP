import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Theme/AppTheme.dart';
import '../Add_to_Cart/Checkout-Information-Shipping.dart';
import '../Add_to_Cart/add_to_card_Provider.dart';

class CorfirmingOrder extends StatefulWidget {
  // final String? usermail;
  // final String? userName;
  // final String? userAddress;
  // final String? userCity;
  // final String? cityPostCode;
  // final String? promoCode;
  // final List<Map<String, String>>? productData;
  //final int? totalPrice;

  CorfirmingOrder(
      {super.key,
      // this.usermail,
      // this.userName,
      // this.userAddress,
      // this.userCity,
      // this.cityPostCode,
      // this.promoCode,
      // this.productData,
      // this.totalPrice,
      });

  @override
  State<CorfirmingOrder> createState() => _CorfirmingOrderState();
}

class _CorfirmingOrderState extends State<CorfirmingOrder> {
  int selectedOption = 1;
  GetStorage _getStorage = GetStorage();
  String? userEmail;
  String? address;
  int totalAmount = 0;
  String? userName;
  String? city;
  String? postCode;
  String promoCode = '';
  List<Map<String, String>>? productData;
  AddToCartProvider obj = AddToCartProvider();
   String? checkPayment ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    print('email: $userEmail');
    print('address: $address');
    print('address: $totalAmount');
    print('address: $userName');
    print('address: $city');
    print('address: $postCode');
    print('address: $promoCode');
    print('address: $productData');
  }
  void _loadData(){
    userEmail  = _getStorage.read('email') ?? '';
    address = _getStorage.read('address') ?? '';
    totalAmount = _getStorage.read('totalAmount');
    userName = _getStorage.read('userFirstName') + _getStorage.read('userLastName');
    city = _getStorage.read('city');
    postCode = _getStorage.read('postCode');
    promoCode = _getStorage.read('promoCode');
    productData = _getStorage.read('productDetails');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(CheckOutInformationShipping(
              // usermail: widget.usermail,
              // userName: widget.userName,
              // //userLastName: widget.userName,
              // userAddress: widget.userAddress,
              // userCity: widget.userCity,
              // cityPostCode: widget.cityPostCode,
              // promoCode: widget.promoCode,
              // productData: widget.productData,
            ));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
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
                      Get.to(CheckOutInformationShipping(
                        // usermail: widget.usermail,
                        // userName: widget.userName,
                        // //userLastName: widget.userName,
                        // userAddress: widget.userAddress,
                        // userCity: widget.userCity,
                        // cityPostCode: widget.cityPostCode,
                        // promoCode: widget.promoCode,
                        // productData: widget.productData,
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
                      prefixIcon: Icon(Icons.location_on,color: ColorTheme.bgcolor),
                      labelText: "Contact",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                  child: Text(
                      userEmail ?? ''
                    //'${widget.userAddress.toString() + widget.userCity.toString()}'
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
            thickness: 2,
            height: 10,
            color: Colors.grey[500],
          ),

          //total
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Price",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PKR ${totalAmount}",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            thickness: 8,
            height: 20,
            color: Colors.grey[200],
          ),

          // payment method
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Paymnt Method",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),

          ListTile(
            title: const Text('Cash on Delivery (COD)'),
            leading: Radio(
              value: 1,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Debit-Credit Card'),
            leading: Radio(
              value: 2,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
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
                    if (selectedOption == 1)
                      {
                        setState(() {
                          checkPayment = 'Cash On Delivery';
                        });
                      }
                    else{
                      setState(() {
                        checkPayment = 'Online payment';
                      });

                    }
                    obj.userShippingDetails(
                      userEmail: userEmail,
                      userName: userName,
                      userAddress: address,
                      userCity: city,
                      cityPostCode:postCode ?? '',
                      promoCode: promoCode ?? '',
                      productDetails: productData,
                      total: totalAmount,
                      payment: checkPayment,
                    );
                    obj.delProductFromCart();
                    print('product list: $productData');
                    obj.addProductToReview(
                      dataList : productData,
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green),
                                    height: 90,
                                    width: 90,
                                    child: Icon(
                                      Icons.done,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                                Text("Congratulations!"),
                                Text(
                                  'Your Oder has been Placed to given shipping address Successfully.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                ElevatedButton(
                                  onPressed: () {

                                    Get.to(BottomNavBar(currentIndex: 0,));
                                    Get.snackbar("Fashio",
                                        'Your Order is it on the way!');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorTheme.bgcolor,
                                      foregroundColor: ColorTheme.btntxtcolor),
                                  child: Text("Finish"),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.bgcolor,
                    foregroundColor: ColorTheme.btntxtcolor,
                  ),
                  child: const Text("Place Order"),
                ),),
          ),
        ],
      ),
    );
  }
}
