import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Checkout-Information-Shipping.dart';
import 'add_to_card_Provider.dart';
import 'add_to_cart.dart';

class CheckOutInformation extends StatefulWidget {
 final List<Map<String , String>>? productData;
 final int? totalAmount ;
  CheckOutInformation(
      {
    super.key,
     this.productData, this.totalAmount,
      });

  @override
  State<CheckOutInformation> createState() => _CheckOutInformationState();
}

class _CheckOutInformationState extends State<CheckOutInformation> {

  final _emailController = new TextEditingController();
  final _firstNameController = new TextEditingController();
  final _lastNameController = new TextEditingController();
  final _addressController = new TextEditingController();
  final _cityController = new TextEditingController();
  final _postCodeController = new TextEditingController();
  final _promoCodeController = new TextEditingController();


  final GetStorage _getStorage = GetStorage();

  @override
  void initState() {

    super.initState();
    _loadData();
  }

  void _loadData(){
    _emailController.text = _getStorage.read('email') ?? '';
    _firstNameController.text = _getStorage.read('userFirstName') ?? '';
    _lastNameController.text = _getStorage.read('userLastName') ?? '';
    _addressController.text = _getStorage.read('address') ?? '';
    _cityController.text = _getStorage.read('city') ?? '';
    _postCodeController.text = _getStorage.read('postCode') ?? '';
    _promoCodeController.text = _getStorage.read('promoCode') ?? '';
  }

  void _saveData(){
    _getStorage.write('email', _emailController.text);
    _getStorage.write('userFirstName', _firstNameController.text);
    _getStorage.write('userLastName', _lastNameController.text);
    _getStorage.write('address', _addressController.text);
    _getStorage.write('city', _cityController.text);
    _getStorage.write('postCode', _postCodeController.text);
    _getStorage.write('promoCode', _promoCodeController.text);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.to(const AddToCartPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 8,
              height: 20,
              color: Colors.grey[200],
            ),
            // information txt
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Contact Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            // email text form field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //shipping info text
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Shipping Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //first and last name txt field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //address txt field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //city and post code field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _postCodeController,
                      decoration: InputDecoration(
                          labelText: 'Post Code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            Divider(
              thickness: 8,
              height: 14,
              color: Colors.grey[200],
            ),

            //promotion
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Promotion',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
            ),

            //code txt field and button
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: _promoCodeController,
                      decoration: InputDecoration(
                          labelText: 'Promo Code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: Text("Apply"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.bgcolor,
                          foregroundColor: ColorTheme.btntxtcolor,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_emailController.text.isEmpty|| _firstNameController.text.isEmpty
                          || _lastNameController.text.isEmpty || _addressController.text.isEmpty
                          || _cityController.text.isEmpty
                      )
                      {
                        Get.snackbar("fashio", "Please Provide complete details");
                      }else
                      {

                        Get.to(CheckOutInformationShipping(
                         //  usermail: _emailController.text,
                         //  userName: _firstNameController.text,
                         // // userLastName: _lastNameController.text,
                         //  userAddress: _addressController.text,
                         //  userCity: _cityController.text,
                         //  cityPostCode: _postCodeController.text ?? '',
                         //  promoCode: _promoCodeController.text ?? '',
                         //  productData: widget.productData,
                         //  totalPrice: widget.totalAmount,
                        ));
                        _saveData();
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.bgcolor,
                      foregroundColor: ColorTheme.btntxtcolor,
                    ),
                    child: const Text("Continue Shipping"),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
