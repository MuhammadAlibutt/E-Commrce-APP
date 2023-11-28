import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_to_card_Provider.dart';
import 'add_to_cart.dart';



class CheckOutScreen extends StatefulWidget {
  final String productImage ;
  final String price;
  final String rating;
  final String title;
  final String storeName;
  const CheckOutScreen({
    super.key,
    required this.productImage,
    required this.price,
    required this.rating,
    required this.title,
    required this.storeName,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String size = '';
  int productQuantity = 0;

  String _selectedSize = '';
  int selectedQuantity = 0;
  AddToCartProvider obj = new AddToCartProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Out'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [

          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 40,
          ),
          SizedBox(height: 15,),

          //product details
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.96,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.23,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorTheme.containerBackground
            ),
            child: Row(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.19,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image.network(widget.productImage),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child: Text(widget.title, maxLines: 4,
                          overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20),),),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,),
                    Text("PKR ${widget.price}", style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text(widget.rating, style: TextStyle(fontSize: 18),),
                          Icon(Icons.star, color: Colors.yellow,)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          Divider(
            thickness: 1,
            color: Colors.grey[500],
          ),

          //select Size
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 25),
            child: Row(
              children: [
                SizedBox(height: 6,),
                Text("Select Size",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Spacer(),
                buildSizeOption("S"),
                buildSizeOption("M"),
                buildSizeOption("L"),
                buildSizeOption("XL"),
              ],
            ),
          ),

          Divider(
            thickness: 1,
            color: Colors.grey[500],
          ),

          // select Quantity
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 25),
            child: Row(
              children: [
                SizedBox(height: 6,),
                Text("Select Quantity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Spacer(),
               IconButton(onPressed: (){
                 setState(() {
                   productQuantity =  productQuantity+ 1;
                   selectedQuantity = productQuantity;
                   print('qunatity: $selectedQuantity');
                 });
               }, icon: Icon(Icons.add_circle_outlined)),
                Container(
                  height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                         '$productQuantity',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    productQuantity = productQuantity - 1;
                    selectedQuantity = productQuantity;
                    print('qunatity: $selectedQuantity');
                  });
                }, icon: Icon(Icons.remove_circle)),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.25,),
          // Add to cart button
          SizedBox(
            height: MediaQuery.of(context).size.height*0.07,
            width: MediaQuery.of(context).size.width*0.7,
            child: ElevatedButton(
                onPressed: (){
                  obj.addProductToCart(
                    productImage: widget.productImage,
                    productTitle: widget.title,
                    productPrice: widget.price,
                    productRating: widget.rating,
                    productquantity: selectedQuantity,
                    productsize: _selectedSize,
                    storeName: widget.storeName,
                  );
                  Get.to(BottomNavBar(currentIndex: 0,));
                  Get.snackbar('Fashio', 'Product added to the Cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.bgcolor,
                  foregroundColor: ColorTheme.btntxtcolor
                ),
                child: Text('Add To Cart')
            ),
          )
        ],
      ),
    );
  }


  //Select Size Widget
  Widget buildSizeOption(String selectedSize) {
    return InkWell(
      onTap: () {
        setState(() {
          size = selectedSize;
          _selectedSize = size;
        });

        print('size: $selectedSize');
      },
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          height:35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
         border: Border.all(
           color: selectedSize == size ? Colors.yellow : Colors.black,
           width: 2
         )
          ),
          child: Center(
            child: Text(
              selectedSize,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selectedSize == size ? FontWeight.bold : FontWeight.normal,
                color: selectedSize == size ? Colors.black : Colors.black, // Change the color here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
